//
//  ApodFavoritesContainerViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 24/04/21.
//

import UIKit

class ApodFavoritesContainerViewController: UIViewController {

    private var shownVc: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = ApodFavoritesContentViewController.fromStoryBoard()
        self.addChild(vc)
        vc.view.pin(to: view)
        vc.didMove(toParent: self)
    }
}
