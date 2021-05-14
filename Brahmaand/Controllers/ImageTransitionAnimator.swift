//
//  ImageTransitionAnimator.swift
//  Brahmaand
//
//  Created by jaydeep on 10/05/21.
//

import UIKit

class ImageTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private static let duration = 2.0 // seconds

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard transitionContext.isAnimated else {
            return
        }

        guard let fromVC = transitionContext.viewController(forKey: .from) as? ApodPageViewController,
              let toVC = transitionContext.viewController(forKey: .to) as? ApodMediaViewController else  {
            transitionContext.completeTransition(true)
            return
        }

        guard let fromMediaView = fromVC.currentShownViewController?.apodMediaView,
              let toImageView = toVC.scrollView.zoomView,
              let fromMediaViewSnap = fromMediaView.snapshotView(afterScreenUpdates: true),
              let toImageViewSnap = toImageView.snapshotView(afterScreenUpdates: true) else {
            transitionContext.completeTransition(true)
            return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromMediaViewSnap)

        let toImageViewRect = toImageView.convert(toImageView.bounds, to: nil)
        fromMediaViewSnap.frame = fromMediaView.frame
        toVC.view.alpha = 0

        UIView.animate(withDuration: Self.duration) {
            fromMediaViewSnap.frame = toImageViewRect
        } completion: { (finished) in
            toVC.view.alpha = 1
            fromMediaViewSnap.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
