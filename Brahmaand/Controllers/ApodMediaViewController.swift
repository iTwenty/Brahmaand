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

    lazy var progressButton: CircularProgressButton = {
        let button = CircularProgressButton(frame: .zero)
        button.addTarget(self, action: #selector(didClickDownloadHdButton(_:)), for: .touchUpInside)
        return button
    }()

    lazy var downloadHdButton: UIBarButtonItem = {
        UIBarButtonItem(customView: progressButton)
    }()

    private var hdImageDownloadTask: DownloadTask?
    private var navBarHidden = true {
        didSet {
            navigationController?.setNavigationBarHidden(navBarHidden, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.setup()
        guard let imgUrl = apod?.url else { return }
        var finalUrl = imgUrl
        if let hdurl = apod?.hdurl, hdImageCached(hdurl: hdurl) {
            finalUrl = hdurl
        }
        configureDownloadHdButton()
        scrollView.imageScrollViewDelegate = self
        navBarHidden = true
        KingfisherManager.shared.retrieveImage(with: finalUrl) { [weak self] (result) in
            switch result {
            case .success(let imageResult):
                self?.showImage(imageResult.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func configureDownloadHdButton() {
        navigationItem.rightBarButtonItem = downloadHdButton
        progressButton.tintColor = downloadHdButton.tintColor
        guard let hdurl = apod?.hdurl else {
            downloadHdButton.isEnabled = false
            return
        }
        if hdImageCached(hdurl: hdurl) {
            downloadHdButton.isEnabled = false
            progressButton.state = .completed
        } else {
            downloadHdButton.isEnabled = true
        }
    }

    private func showImage(_ image: UIImage) {
        scrollView.display(image: image)
    }

    private func hdImageCached(hdurl: URL) -> Bool {
        return KingfisherManager.shared.cache.imageCachedType(forKey: hdurl.absoluteString) != .none
    }

    @objc func didClickDownloadHdButton(_ sender: Any) {
        guard let hdurl = apod?.hdurl else { return }
        if hdImageDownloadTask != nil {
            print("HD download cancelled manually")
            hdImageDownloadTask?.cancel()
            hdImageDownloadTask = nil
            progressButton.state = .initial
            downloadHdButton.isEnabled = true
        } else {
            progressButton.state = .progressing(0)
            hdImageDownloadTask = KingfisherManager.shared.retrieveImage(with: hdurl) { [weak self] (currentBytes, totalBytes) in
                let progress = Float(currentBytes) / Float(totalBytes)
                self?.progressButton.state = .progressing(progress)
            } completionHandler: { [weak self] (result) in
                switch result {
                case .success(let imageResult):
                    print("HD downloaded!")
                    self?.progressButton.state = .completed
                    self?.downloadHdButton.isEnabled = false
                    self?.showImage(imageResult.image)
                case .failure(let error):
                    print("HD download failed : \(error.localizedDescription)")
                    self?.progressButton.state = .initial
                }
            }
        }
    }

    deinit {
        hdImageDownloadTask?.cancel()
    }
}

extension ApodMediaViewController: ImageScrollViewDelegate {

    func imageScrollViewDidChangeOrientation(imageScrollView: ImageScrollView) {
        // WOOT!
    }

    func imageScrollViewSingleTapped() {
        navBarHidden.toggle()
    }
}
