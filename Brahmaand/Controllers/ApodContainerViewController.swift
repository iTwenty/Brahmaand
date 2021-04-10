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
    var date: Date
    var dateSelectAction: ((Date, UIPageViewController.NavigationDirection) -> ())

    init(date: Date, dateSelectAction: @escaping ((Date, UIPageViewController.NavigationDirection) -> ())) {
        self.date = date
        self.dateSelectAction = dateSelectAction
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
        self.addChild(newVc)
        newVc.view.pin(to: view)
        newVc.didMove(toParent: self)
    }

    private func fetchApod() {
        setState(.loading, animated: false)
        ApodCompositeFetcher.fetchApod(forDate: date, options: nil) { (result) in
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
            return ApodContentViewController.fromStoryBoard(apod: apod, dateSelectAction: dateSelectAction)
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
