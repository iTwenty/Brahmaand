//
//  ApodFavoritesEmptyViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 24/04/21.
//

import UIKit

class ApodFavoritesEmptyViewController: UIViewController {

    static func fromStoryBoard() -> ApodFavoritesEmptyViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc: ApodFavoritesEmptyViewController = sb.instantiateViewController(identifier: "ApodFavoritesEmptyViewController")
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
