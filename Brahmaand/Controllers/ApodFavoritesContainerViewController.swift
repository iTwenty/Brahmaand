//
//  ApodFavoritesContainerViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 24/04/21.
//

import UIKit

class ApodFavoritesContainerViewController: UIViewController {

    private var state: State?
    private var shownVc: UIViewController?

    private let apodFavoritesManager = ApodFactory.makeApodFavoritesManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFavorites()
        apodFavoritesManager.onApodAddedToFavorites = { [weak self] (date) in
            self?.fetchFavorites()
        }
        apodFavoritesManager.onApodRemovedFromFavorites = { [weak self] (date) in
            self?.fetchFavorites()
        }
    }

    deinit {
        apodFavoritesManager.onApodAddedToFavorites = nil
        apodFavoritesManager.onApodRemovedFromFavorites = nil
    }

    private func fetchFavorites() {
        setState(.loading, animated: true)
        apodFavoritesManager.fetchFavoriteApods { (result) in
            switch result {
            case .success(let apods):
                DispatchQueue.main.async {
                    self.setState(.success(apods), animated: true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.setState(.failure(error), animated: true)
                }
            }
        }
    }

    private func setState(_ state: State, animated: Bool) {
        shownVc?.willMove(toParent: nil)
        shownVc?.view.removeFromSuperview()
        shownVc?.removeFromParent()
        let newVc = viewController(forState: state)
        self.addChild(newVc)
        newVc.view.pin(to: view)
        newVc.didMove(toParent: self)
    }

    private func viewController(forState state: State) -> UIViewController {
        switch state {
        case .loading:
            return ApodLoadingViewController.fromStoryBoard()
        case .failure:
            return ApodFailureViewController.fromStoryBoard()
        case .success(let apods):
            if apods.isEmpty {
                return ApodFavoritesEmptyViewController.fromStoryBoard()
            } else {
                return ApodFavoritesContentViewController.fromStoryBoard(apods: apods)
            }
        }
    }
}

extension ApodFavoritesContainerViewController {
    enum State {
        case loading
        case failure(Error)
        case success([Apod])
    }
}
