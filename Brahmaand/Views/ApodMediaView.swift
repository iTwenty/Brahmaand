//
//  ApodMediaView.swift
//  Brahmaand
//
//  Created by jaydeep on 04/04/21.
//

import UIKit
import Kingfisher
import YoutubePlayer_in_WKWebView

class ApodMediaView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var youtubeView: WKYTPlayerView!
    @IBOutlet weak var loadingContainerView: UIView!
    @IBOutlet weak var contentView: UIView!

    var imageTapAction: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("ApodMediaView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        self.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
    }

    func loadYoutubeVideo(videoCode: String) {
        self.youtubeView.isHidden = false
        self.imageView.isHidden = true
        self.loadingContainerView.isHidden = true

        self.youtubeView.load(withVideoId: videoCode)
    }

    func loadImage(url: URL, completion: (() -> ())? = nil) {
        self.loadingContainerView.isHidden = false
        self.youtubeView.isHidden = true
        self.imageView.isHidden = true

        KingfisherManager.shared.retrieveImage(with: url,
                                               options: [.scaleFactor(UIScreen.main.scale),
                                                         .transition(.fade(1)),
                                                         .cacheOriginalImage],
                                               progressBlock: nil,
                                               downloadTaskUpdated: nil) { [weak self] (result) in
            switch result {
            case .success(let imageResult):
                self?.showImage(imageResult.image)
                completion?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func showImage(_ image: UIImage) {
        self.imageView.isHidden = false
        self.loadingContainerView.isHidden = true
        self.youtubeView.isHidden = true

        let imageWidth = image.size.width
        let imageHeight = image.size.height

        let imageViewWidth = imageView.bounds.size.width
        let imageScaleRatio = imageViewWidth / imageWidth

        let resizedImage = image.resized(size: CGSize(width: imageWidth * imageScaleRatio, height: imageHeight * imageScaleRatio))
        imageView.image = resizedImage

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage(_:)))
        tapGesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tapGesture)
    }

    @objc private func didTapImage(_ sender: Any) {
        imageTapAction?()
    }
}
