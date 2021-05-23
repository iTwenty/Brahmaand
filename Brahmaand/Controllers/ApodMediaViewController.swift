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

    private var apod: Apod
    private var initialImage: UIImage

    static func fromStoryboard(apod: Apod, image: UIImage) -> ApodMediaViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        return sb.instantiateViewController(identifier: "ApodMediaViewController") { (coder) in
            return ApodMediaViewController(apod: apod, image: image, coder: coder)
        }
    }

    required init?(apod: Apod, image: UIImage, coder: NSCoder) {
        self.apod = apod
        self.initialImage = image
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(apod:image:coder:) instead")
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
        showImage(initialImage)

        guard let hdurl = apod.hdurl else {
            navigationItem.rightBarButtonItems = [shareButton]
            return
        }

        navigationItem.rightBarButtonItems = [shareButton, downloadHdButton]
        progressButton.tintColor = downloadHdButton.tintColor
    
        if hdImageCached(hdurl: hdurl) {
            downloadHdButton.isEnabled = false
            progressButton.state = .completed
            KingfisherManager.shared.retrieveImage(with: hdurl) { [weak self] (result) in
                switch result {
                case .success(let imageResult):
                    self?.showImage(imageResult.image)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            downloadHdButton.isEnabled = true
            progressButton.state = .initial
        }
        navBarHidden = true
    }

    private func showImage(_ image: UIImage) {
        scrollView.display(image: image)
    }

    private func hdImageCached(hdurl: URL) -> Bool {
        return KingfisherManager.shared.cache.imageCachedType(forKey: hdurl.absoluteString) != .none
    }

    @objc func didClickDownloadHdButton(_ sender: Any) {
        guard let hdurl = apod.hdurl else { return }
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
