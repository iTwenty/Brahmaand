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

    lazy var shareButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didClickShareButton(_:)))
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
        scrollView.imageScrollViewDelegate = self

        guard let imgUrl = apod?.url else { return }
        var finalUrl = imgUrl
        var hdImageInCache = false
        if let hdurl = apod?.hdurl, hdImageCached(hdurl: hdurl) {
            finalUrl = hdurl
            hdImageInCache = true
        }
        configureNavigationBar(hdImageInCache: hdImageInCache)
        KingfisherManager.shared.retrieveImage(with: finalUrl) { [weak self] (result) in
            switch result {
            case .success(let imageResult):
                self?.showImage(imageResult.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func configureNavigationBar(hdImageInCache: Bool) {
        navBarHidden = true
        navigationItem.rightBarButtonItems = [shareButton, downloadHdButton]
        progressButton.tintColor = downloadHdButton.tintColor
        if hdImageInCache {
            downloadHdButton.isEnabled = false
            progressButton.state = .completed
        } else {
            downloadHdButton.isEnabled = true
            progressButton.state = .initial
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
                    self?.downloadHdButton.isEnabled = true
                }
            }
        }
    }

    @objc func didClickShareButton(_ sender: Any) {
        guard let shareImage = scrollView.zoomView?.image else { return }
        let shareVc = UIActivityViewController(activityItems: [shareImage], applicationActivities: nil)
        self.present(shareVc, animated: true, completion: nil)
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
