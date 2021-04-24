//
//  ApodGridViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import UIKit

class ApodContentViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var apodMediaView: ApodMediaView!
    @IBOutlet weak var apodTitleLabel: UILabel!
    @IBOutlet weak var apodExplanationTextView: UITextView!

    @IBOutlet weak var apodMediaViewHeightConstraint: NSLayoutConstraint!

    var apod: Apod?

    static func fromStoryBoard(apod: Apod) -> ApodContentViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc: ApodContentViewController = sb.instantiateViewController(identifier: "ApodContentViewController")
        vc.apod = apod
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        showApod()
    }

    private func setupViews() {
        apodTitleLabel.text = nil
        apodExplanationTextView.text = nil
        apodMediaView.imageTapAction = { [weak self] in
            self?.showFullScreenImage()
        }
    }

    private func showApod() {
        guard let apod = apod else { return }
        apodTitleLabel.text = apod.title
        apodExplanationTextView.text = apod.explanation
        switch apod.mediaType {
        case .image:
            self.loadImage(url: apod.url)
        case .video:
            self.loadVideo(url: apod.url)
        }
    }

    private func loadImage(url: URL) {
        self.apodMediaView.loadImage(url: url) { (image) in
            self.apodMediaViewHeightConstraint.isActive = false
            self.setBackgroundColor(fromImage: image)
        }
    }

    private func loadVideo(url: URL) {
        self.apodMediaViewHeightConstraint.isActive = true
        guard let host = url.host else { return }
        if host.contains("youtube") {
            let videoCode = url.lastPathComponent
            self.apodMediaView.loadYoutubeVideo(videoCode: videoCode)
        } else {
            // TODO some other video site. load in wkwebview??
        }
    }

    private func showFullScreenImage() {
        guard let apod = apod else { return }
        ApodNavigator.shared.showFullScreenImage(apod: apod, presenter: self)
    }

    private func setBackgroundColor(fromImage image: UIImage) {
        image.getColors { [weak self] (colors) in
            guard let colors = colors else { return }
            UIView.animate(withDuration: 0.1) {
                self?.view.backgroundColor = colors.background
                self?.apodTitleLabel.textColor = colors.primary
                self?.apodExplanationTextView.textColor = colors.detail
            }
        }
    }
}
