//
//  ApodNavigationController.swift
//  Brahmaand
//
//  Created by jaydeep on 09/05/21.
//

import UIKit

class ApodNavigationController: UINavigationController {

    private let initialFetchType: FetchType

    static func fromStoryboard(initialFetchType: FetchType) -> ApodNavigationController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(identifier: "ApodNavigationController") { (coder) in
            ApodNavigationController(initialFetchType: initialFetchType, coder: coder)
        }
    }

    required init?(initialFetchType: FetchType, coder: NSCoder) {
        self.initialFetchType = initialFetchType
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        self.initialFetchType = .before(date: Date())
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([ApodPageViewController.fromStoryboard(initialFetchType: initialFetchType)], animated: true)
    }
}
