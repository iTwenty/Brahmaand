//
//  ImageTransitionAnimator.swift
//  Brahmaand
//
//  Created by jaydeep on 10/05/21.
//

import UIKit

class ImageTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private static let duration = 0.5 // seconds

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
              let toView = toVC.view else  {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }

        guard let fromImageView = fromVC.currentShownViewController?.apodMediaView,
              let toImageView = toVC.scrollView.zoomView else {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(toView)

        let transitionImageViewInitialFrame = fromImageView.convert(fromImageView.bounds, to: fromVC.view)
        let transitionImageViewFinalFrame = toImageView.convert(toImageView.bounds, to: toView)

        let transitionImageView = UIImageView(image: toImageView.image)
        transitionImageView.contentMode = .scaleAspectFill
        transitionImageView.frame = transitionImageViewInitialFrame
        containerView.addSubview(transitionImageView)

        toVC.scrollView.isHidden = true
        toView.alpha = 0
        UIView.animate(withDuration: Self.duration) {
            transitionImageView.frame = transitionImageViewFinalFrame
            toView.alpha = 1
        } completion: { (finished) in
            transitionImageView.removeFromSuperview()
            toVC.scrollView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
