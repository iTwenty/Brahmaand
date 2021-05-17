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
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }

        guard let fromVC = transitionContext.viewController(forKey: .from) as? ApodPageViewController,
              let toVC = transitionContext.viewController(forKey: .to) as? ApodMediaViewController,
              let toView = transitionContext.view(forKey: .to) else  {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }

        guard let fromMediaView = fromVC.currentShownViewController?.apodMediaView,
              let fromMediaViewSnap = fromMediaView.snapshotView(afterScreenUpdates: false),
              let toImageView = toVC.scrollView.zoomView else {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }

        let fromMediaViewSnapInitialFrame = fromMediaView.convert(fromMediaView.bounds, to: nil)
        let fromMediaViewSnapFinalFrame = toImageView.convert(toImageView.bounds, to: nil)

        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.addSubview(fromMediaViewSnap)
        fromMediaViewSnap.frame = fromMediaViewSnapInitialFrame
        toView.alpha = 0

        UIView.animate(withDuration: Self.duration) {
            fromMediaViewSnap.frame = fromMediaViewSnapFinalFrame
        } completion: { (finished) in
            toView.alpha = 1
            fromMediaViewSnap.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
