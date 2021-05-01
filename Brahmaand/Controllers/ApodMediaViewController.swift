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

    lazy var downloadHdButton: UIBarButtonItem = {
        let downloadHdImage = UIImage(systemName: "arrow.down.to.line")
        let button = UIBarButtonItem(image: downloadHdImage, style: .plain, target: self, action: #selector(didClickDownloadHdButton(_:)))
        return button
    }()

    private var hdImageDownloadTask: DownloadTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.setup()
        guard let imgUrl = apod?.url else { return }
        var finalUrl = imgUrl
        if let hdurl = apod?.hdurl, hdImageCached(hdurl: hdurl) {
            finalUrl = hdurl
        }
        configureDownloadHdButton()
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
        self.navigationItem.rightBarButtonItem = downloadHdButton
        guard let hdurl = apod?.hdurl else {
            downloadHdButton.isEnabled = false
            return
        }
        guard !hdImageCached(hdurl: hdurl) else {
            downloadHdButton.isEnabled = false
            return
        }
        downloadHdButton.isEnabled = true
    }

    private func showImage(_ image: UIImage) {
        scrollView.display(image: image)
    }

    private func hdImageCached(hdurl: URL) -> Bool {
        return KingfisherManager.shared.cache.imageCachedType(forKey: hdurl.absoluteString) != .none
    }

    @objc func didClickDownloadHdButton(_ sender: Any) {
        downloadHdButton.isEnabled = false
        guard let hdurl = apod?.hdurl else { return }
        hdImageDownloadTask = KingfisherManager.shared.retrieveImage(with: hdurl) { (currentBytes, totalBytes) in
            print("Downloaded \(currentBytes) / \(totalBytes)")
        } completionHandler: { [weak self] (result) in
            switch result {
            case .success(let imageResult):
                print("HD downloaded!")
                self?.showImage(imageResult.image)
            case .failure(let error):
                print("HD download failed : \(error.localizedDescription)")
                self?.downloadHdButton.isEnabled = true
            }
        }
    }

    deinit {
        hdImageDownloadTask?.cancel()
    }
}
