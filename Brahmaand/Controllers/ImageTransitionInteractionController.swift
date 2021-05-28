//
//  ImageTransitionInteractionController.swift
//  Brahmaand
//
//  Created by jaydeep on 27/05/21.
//

import UIKit

class ImageTransitionInteractionController: UIPercentDrivenInteractiveTransition {

    private var interactionInProgress = false

    override init() {
        super.init()
        setupPanGesture()
    }

    private func setupPanGesture() {
    }
}
