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

    private var apod: Apod?

    static func fromStoryboard(apod: Apod) -> ApodMediaViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc: ApodMediaViewController = sb.instantiateViewController(identifier: "ApodMediaViewController")
        vc.apod = apod
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let imgUrl = apod?.url else { return }
        KingfisherManager.shared.retrieveImage(with: imgUrl) { [weak self] (result) in
            switch result {
            case .success(let imageResult):
                self?.showImage(imageResult.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        scrollView.delegate = self
    }

    private func showImage(_ image: UIImage) {
        self.imageView.image = image
        updateMinZoomScale(forSize: view.bounds.size)
    }

    private func updateMinZoomScale(forSize size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = min(1, minScale)
        scrollView.maximumZoomScale = 2
        scrollView.zoomScale = scrollView.minimumZoomScale
    }

    private func updateContentInset() {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
}

extension ApodMediaViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateContentInset()
    }
}
