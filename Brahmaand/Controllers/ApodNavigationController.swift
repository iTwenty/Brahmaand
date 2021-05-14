//
//  ApodNavigationController.swift
//  Brahmaand
//
//  Created by jaydeep on 09/05/21.
//

import UIKit

class ApodNavigationController: UINavigationController {

    private let initialFetchType: FetchType

    static func fromStoryboard(initialFetchType: FetchType) -> ApodNavigationController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(identifier: "ApodNavigationController") { (coder) in
            ApodNavigationController(initialFetchType: initialFetchType, coder: coder)
        }
    }

    required init?(initialFetchType: FetchType, coder: NSCoder) {
        self.initialFetchType = initialFetchType
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        self.initialFetchType = .before(date: Date())
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setViewControllers([ApodPageViewController.fromStoryboard(initialFetchType: initialFetchType)], animated: true)
    }
}

extension ApodNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push: return pushAnimator(navigationController, fromVC: fromVC, toVC: toVC)
        default: return nil
        }
    }

    func pushAnimator(_ navVC: UINavigationController, fromVC: UIViewController,
                      toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard fromVC is ApodPageViewController, toVC is ApodMediaViewController else {
            return nil
        }
        return ImageTransitionAnimator()
    }
}
