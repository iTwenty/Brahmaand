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
    @IBOutlet weak var contentView: UIView!

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

    func loadImage(url: URL) {
        KingfisherManager.shared.retrieveImage(with: url,
                                               options: [.scaleFactor(UIScreen.main.scale),
                                                         .transition(.fade(1)),
                                                         .cacheOriginalImage],
                                               progressBlock: nil,
                                               downloadTaskUpdated: nil) { [weak self] (result) in
            switch result {
            case .success(let imageResult):
                self?.resize(imageResult.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func resize(_ image: UIImage) {
        let imageWidth = image.size.width
        let imageViewWidth = imageView.bounds.size.width
        let resizeFactor = imageWidth / imageViewWidth
        if resizeFactor <= 1.0 {
            imageView.image = image
        } else {
            imageView.image = image.resized(size: CGSize(width: imageViewWidth, height: image.size.height * resizeFactor))
        }
    }
}
