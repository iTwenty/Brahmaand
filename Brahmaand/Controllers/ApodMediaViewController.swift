//
//  ApodMediaViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 10/04/21.
//

import UIKit
import Kingfisher

class ApodMediaViewController: UIViewController {

    @IBOutlet weak var scrollView: ImageScrollView!

    private var apod: Apod?

    static func fromStoryboard(apod: Apod) -> ApodMediaViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc: ApodMediaViewController = sb.instantiateViewController(identifier: "ApodMediaViewController")
        vc.apod = apod
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.setup()
        guard let imgUrl = apod?.url else { return }
        KingfisherManager.shared.retrieveImage(with: imgUrl) { [weak self] (result) in
            switch result {
            case .success(let imageResult):
                self?.showImage(imageResult.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func showImage(_ image: UIImage) {
        scrollView.display(image: image)
    }
}
