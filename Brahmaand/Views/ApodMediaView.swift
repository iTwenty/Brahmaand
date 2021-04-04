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
    @IBOutlet var youtubeView: WKYTPlayerView!
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
    }

    func loadMedia(fromApod apod: Apod) {
        switch apod.mediaType {
        case .image:
            self.loadImage(url: apod.url)
        case .video:
            self.loadVideo(url: apod.url)
        }
    }

    private func loadImage(url: URL) {
        self.youtubeView.isHidden = true
        self.imageView.isHidden = false
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIActivityIndicatorView(style: .medium),
            options: [.processor(processor),
                      .scaleFactor(UIScreen.main.scale),
                      .transition(.fade(1)),
                      .cacheOriginalImage]) { [weak self] (result) in
            switch result {
            case .success(let value):
                print("success \(value.source.url?.absoluteString ?? "")")
                //self?.setBackgroundColor(fromImage: value.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func loadVideo(url: URL) {
        self.youtubeView.isHidden = false
        self.imageView.isHidden = true
        youtubeView.loadVideo(byURL: url.absoluteString, startSeconds: 0, suggestedQuality: .auto)
    }
}
