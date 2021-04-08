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
    @IBOutlet weak var apodDateButton: UIButton!
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
        self.apodTitleLabel.text = apod.title
        self.apodDateButton.setTitle(apod.date.displayFormatted(), for: .normal)
        self.apodExplanationTextView.text = apod.explanation
        switch apod.mediaType {
        case .image:
            self.loadImage(url: apod.url)
        case .video:
            self.loadVideo(url: apod.url)
        }
    }

    private func loadImage(url: URL) {
        self.apodMediaView.loadImage(url: url)
    }

    private func loadVideo(url: URL) {
        guard let host = url.host else { return }
        if host.contains("youtube") {
            let videoCode = url.lastPathComponent
            let imgUrlString = "https://img.youtube.com/vi/\(videoCode)/maxresdefault.jpg"
            guard let imgUrl = URL(string: imgUrlString) else { return }
            loadImage(url: imgUrl)
        } else {
            // TODO some other video site. load in wkwebview??
        }
    }
    @IBAction func didClickApodDateButton(_ sender: Any) {
        print("clicked")
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
