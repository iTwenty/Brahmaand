//
//  ApodLoadingViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 09/04/21.
//

import UIKit

class ApodLoadingViewController: UIViewController {

    static func fromStoryBoard() -> ApodLoadingViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        return sb.instantiateViewController(identifier: "ApodLoadingViewController")
    }
}
