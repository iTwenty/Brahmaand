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

    func pushApodMediaViewController(apod: Apod, presenter: UIViewController) {
        let mediaVc = ApodMediaViewController.fromStoryboard(apod: apod)
        mediaVc.title = apod.title
        mediaVc.hidesBottomBarWhenPushed = true
        presenter.navigationController?.pushViewController(mediaVc, animated: true)
    }

    func presentApodContentViewController(apod: Apod, presenter: UIViewController) {
        let navigationVc = ApodNavigationController.fromStoryboard(initialFetchType: .single(date: apod.date))
        presenter.present(navigationVc, animated: true, completion: nil)
    }
}
