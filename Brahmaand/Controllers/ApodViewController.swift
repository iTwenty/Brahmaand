//
//  ApodGridViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import UIKit
import Kingfisher

class ApodViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var apodImageView: UIImageView!
    @IBOutlet weak var apodTitleLabel: UILabel!
    @IBOutlet weak var apodExplanationTextView: UITextView!

    private var apod: Apod?
    var index: Int?

    static func fromStoryBoard(apod: Apod, index: Int) -> ApodViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc: ApodViewController = sb.instantiateViewController(identifier: "ApodViewController")
        vc.apod = apod
        vc.index = index
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        resetViews()
        self.showApod()
    }

    private func resetViews() {
        self.apodImageView.image = nil
        self.apodTitleLabel.text = nil
        self.apodExplanationTextView.text = nil
    }

    private func showApod() {
        guard let apod = self.apod else { return }
        let processor = DownsamplingImageProcessor(size: apodImageView.bounds.size)
        apodImageView.kf.indicatorType = .activity
        apodImageView.kf.setImage(
            with: apod.url,
            options: [.processor(processor),
                      .scaleFactor(UIScreen.main.scale),
                      .transition(.fade(1)),
                      .cacheOriginalImage]) { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.setBackgroundColor(fromImage: value.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.apodTitleLabel.text = apod.title
        self.apodExplanationTextView.text = apod.explanation
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
