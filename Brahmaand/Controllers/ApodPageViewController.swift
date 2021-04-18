//
//  ApodPageViewController.swift
//  Brahmaand
//
//  Created by Jaydeep Joshi on 27/03/21.
//

import UIKit

class ApodPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        let apodVc = ApodContainerViewController(fetchType: .before(date: Date()), dateSelectAction: jumpToDate(_:_:))
        self.setViewControllers([apodVc], direction: .reverse, animated: false, completion: nil)
    }

    func jumpToDate(_ date: Date, _ direction: UIPageViewController.NavigationDirection) {
        let apodVc = ApodContainerViewController(fetchType: .middle(date: date), dateSelectAction: jumpToDate(_:_:))
        self.setViewControllers([apodVc], direction: direction, animated: true, completion: nil)
    }
}


extension ApodPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentDate = (viewController as? ApodContainerViewController)?.fetchType.date else {
            return nil
        }
        guard let beforeDate = Constants.Calendars.apodCalendar.date(byAdding: .day, value: -1, to: currentDate) else {
            return nil
        }
        let comparison = Constants.Calendars.apodCalendar.compare(Constants.Dates.apodLaunchDate, to: beforeDate, toGranularity: .day)
        guard comparison == .orderedSame || comparison == .orderedAscending else {
            return nil
        }
        let apodVc = ApodContainerViewController(fetchType: .before(date: beforeDate), dateSelectAction: jumpToDate(_:_:))
        return apodVc
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentDate = (viewController as? ApodContainerViewController)?.fetchType.date else {
            return nil
        }
        guard let afterDate = Constants.Calendars.apodCalendar.date(byAdding: .day, value: 1, to: currentDate) else {
            return nil
        }
        let comparison = Constants.Calendars.apodCalendar.compare(afterDate, to: Date(), toGranularity: .day)
        guard comparison == .orderedSame || comparison == .orderedAscending else {
            return nil
        }
        let apodVc = ApodContainerViewController(fetchType: .after(date: afterDate), dateSelectAction: jumpToDate(_:_:))
        return apodVc
    }
}
