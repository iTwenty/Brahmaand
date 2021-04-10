//
//  ApodMediaViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 10/04/21.
//

import UIKit
import Kingfisher

class ApodMediaViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!

    private var apod: Apod?

    static func fromStoryboard(apod: Apod) -> ApodMediaViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc: ApodMediaViewController = sb.instantiateViewController(identifier: "ApodMediaViewController")
        vc.apod = apod
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.kf.setImage(with: apod?.url)
        scrollView.delegate = self
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScale(forSize: view.bounds.size)
        //updateConstraints(forSize: view.bounds.size)
    }

    func updateMinZoomScale(forSize size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 2
        scrollView.zoomScale = minScale
    }

    func updateConstraints(forSize size: CGSize) {
        let yOffset = max(0, (size.height - imageView.bounds.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset

        let xOffset = max(0, (size.width - imageView.bounds.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset

        view.layoutIfNeeded()
    }
}

extension ApodMediaViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
