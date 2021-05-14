//
//  ApodContainerViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 09/04/21.
//

import UIKit

class ApodContainerViewController: UIViewController {

    private var state: State?
    private var shownVc: UIViewController?

    var fetchType: FetchType

    // Apod Media view for current shown apod. Used by ApodNavigationController for custom VC transitions
    var apodMediaView: ApodMediaView? {
        guard let contentVC = shownVc as? ApodContentViewController else { return nil }
        return contentVC.apodMediaView
    }

    init(fetchType: FetchType) {
        self.fetchType = fetchType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchApod()
    }

    func setState(_ state: State, animated: Bool) {
        shownVc?.willMove(toParent: nil)
        shownVc?.view.removeFromSuperview()
        shownVc?.removeFromParent()
        let newVc = viewController(forState: state)
        shownVc = newVc
        self.addChild(newVc)
        newVc.view.pin(to: view)
        newVc.didMove(toParent: self)
    }

    private func fetchApod() {
        setState(.loading, animated: false)
        ApodCompositeFetcher.fetchApod(fetchType: fetchType, options: nil) { (result) in
            switch result {
            case .success(let apod):
                DispatchQueue.main.async {
                    self.setState(.success(apod), animated: true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.setState(.failure(error), animated: true)
                }
            }
        }
    }

    private func viewController(forState state: State) -> UIViewController {
        switch state {
        case .loading:
            return ApodLoadingViewController.fromStoryBoard()
        case .failure(let error):
            print(error.localizedDescription)
            return ApodFailureViewController.fromStoryBoard()
        case .success(let apod):
            return ApodContentViewController.fromStoryBoard(apod: apod)
        }
    }
}

extension ApodContainerViewController {
    enum State {
        case loading
        case failure(Error)
        case success(Apod)
    }
}
