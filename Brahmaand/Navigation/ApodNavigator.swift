//
//  ApodNavigator.swift
//  Brahmaand
//
//  Created by jaydeep on 10/04/21.
//

import Foundation
import UIKit

class ApodNavigator {

    private init() {}
    static let shared = ApodNavigator()

    func showFullScreenImage(apod: Apod, presenter: UIViewController) {
        let mediaVc = ApodMediaViewController.fromStoryboard(apod: apod)
        presenter.present(mediaVc, animated: true, completion: nil)
    }
}
