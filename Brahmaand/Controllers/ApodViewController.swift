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

    private var apodNetwork: ApodNetwork?
    private var apod: Apod?

    override func viewDidLoad() {
        super.viewDidLoad()
        resetViews()
        apodNetwork = ApodApiNetwork()
        apodNetwork?.fetchApod(forDate: Date()) { [weak self] (result) in
            switch result {
            case .success(let apod):
                DispatchQueue.main.async {
                    self?.apod = apod
                    self?.showApod()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func resetViews() {
        self.apodImageView.image = nil
        self.apodTitleLabel.text = nil
        self.apodExplanationTextView.text = nil
    }

    private func showApod() {
        guard let apod = self.apod else { return }
        self.apodImageView.kf.setImage(with: apod.url)
        self.apodTitleLabel.text = apod.title
        self.apodExplanationTextView.text = apod.explanation
    }
}
