//
//  ApodPageViewController.swift
//  Brahmaand
//
//  Created by Jaydeep Joshi on 27/03/21.
//

import UIKit

class ApodPageViewController: UIPageViewController {

    private var apodNetwork: ApodNetwork?
    private var apods: [Apod] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        apodNetwork = ApodApiNetwork()
        guard let start = Calendar.current.date(byAdding: .month, value: -1, to: Date()) else { return }
        apodNetwork?.fetchApods(startDate: start, endDate: Date()) { [weak self] (result) in
            switch result {
            case .success(let apods):
                DispatchQueue.main.async {
                    self?.apods = apods
                    guard let latest = self?.apods.last else { return }
                    let apodVc = ApodViewController.fromStoryBoard(apod: latest, index: apods.endIndex - 1)
                    self?.setViewControllers([apodVc], direction: .reverse, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension ApodPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = (viewController as? ApodViewController)?.index else {
            return nil
        }
        let beforeIndex = apods.index(before: currentIndex)
        guard beforeIndex >= apods.startIndex else {
            return nil
        }
        let apodVc = ApodViewController.fromStoryBoard(apod: apods[beforeIndex], index: beforeIndex)
        return apodVc
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = (viewController as? ApodViewController)?.index else {
            return nil
        }
        let afterIndex = apods.index(after: currentIndex)
        guard afterIndex < apods.endIndex else {
            return nil
        }
        let apodVc = ApodViewController.fromStoryBoard(apod: apods[afterIndex], index: afterIndex)
        return apodVc
    }
}

extension ApodPageViewController: UIPageViewControllerDelegate {

}
