//
//  ApodNavigationController.swift
//  Brahmaand
//
//  Created by jaydeep on 09/05/21.
//

import UIKit

class ApodNavigationController: UINavigationController {

    static func fromStoryboard() -> ApodNavigationController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(identifier: "ApodNavigationController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension ApodNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push: return pushAnimator(navigationController, fromVC: fromVC, toVC: toVC)
        case .pop: return popAnimator(navigationController, fromVC: fromVC, toVC: toVC)
        default: return nil
        }
    }

    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }

    func pushAnimator(_ navVC: UINavigationController, fromVC: UIViewController,
                      toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard fromVC is ApodPageViewController, toVC is ApodMediaViewController else {
            return nil
        }
        return ImageTransitionAnimator(direction: .forward)
    }

    func popAnimator(_ navVC: UINavigationController, fromVC: UIViewController,
                     toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard fromVC is ApodMediaViewController, toVC is ApodPageViewController else {
            return nil
        }
        return ImageTransitionAnimator(direction: .back)
    }
}
