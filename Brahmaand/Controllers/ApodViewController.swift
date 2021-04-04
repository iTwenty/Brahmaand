//
//  ApodGridViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import UIKit
import Kingfisher

extension UIActivityIndicatorView : Placeholder {}

class ApodViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var apodMediaView: ApodMediaView!
    @IBOutlet weak var apodTitleLabel: UILabel!
    @IBOutlet weak var apodExplanationTextView: UITextView!

    var date: Date?

    static func fromStoryBoard(date: Date) -> ApodViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc: ApodViewController = sb.instantiateViewController(identifier: "ApodViewController")
        vc.date = date
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        resetViews()
        self.fetchApod()
    }

    private func resetViews() {
        self.apodTitleLabel.text = nil
        self.apodExplanationTextView.text = nil
    }

    private func fetchApod() {
        guard let date = date else { return }
        ApodCompositeFetcher.fetchApod(forDate: date, options: nil) { (result) in
            switch result {
            case .success(let apod):
                DispatchQueue.main.async {
                    self.showApod(apod)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func showApod(_ apod: Apod) {
        self.apodMediaView.loadMedia(fromApod: apod)
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
