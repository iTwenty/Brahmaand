//
//  ApodFailureViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 09/04/21.
//

import UIKit

class ApodFailureViewController: UIViewController {

    static func fromStoryBoard() -> ApodFailureViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        return sb.instantiateViewController(identifier: "ApodFailureViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
