//
//  ApodPageViewController.swift
//  Brahmaand
//
//  Created by Jaydeep Joshi on 27/03/21.
//

import UIKit
import Parchment

struct PagingDateItem: PagingItem, Hashable, Comparable {

    let date: Date
    let dayText: String?
    let monthText: String?
    let yearText: String?

    init(date: Date) {
        self.date = date
        self.dayText = Constants.DateFormatters.displayDayFormatter.string(from: date)
        self.monthText = Constants.DateFormatters.displayMonthFormatter.string(from: date)
        self.yearText = Constants.DateFormatters.displayYearFormatter.string(from: date)
    }

    static func < (lhs: PagingDateItem, rhs: PagingDateItem) -> Bool {
        lhs.date < rhs.date
    }
}

class ApodPageViewController: PagingViewController {

    var days: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        days = Constants.Calendars.apodCalendar.dateComponents([.day], from: Constants.Dates.apodLaunchDate, to: Date()).day!
        self.dataSource = self
        let nib = UINib(nibName: "ApodDateCell", bundle: nil)
        self.menuItemSize = .selfSizing(estimatedWidth: 64, height: 64)
        self.register(nib, for: PagingDateItem.self)
        self.select(index: days - 1)
    }
}


extension ApodPageViewController: PagingViewControllerDataSource {

    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return days
    }

    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let date = Constants.Calendars.apodCalendar.date(byAdding: .day, value: index, to: Constants.Dates.apodLaunchDate)!
        return ApodViewController.fromStoryBoard(date: date)
    }

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let date = Constants.Calendars.apodCalendar.date(byAdding: .day, value: index, to: Constants.Dates.apodLaunchDate)!
        return PagingDateItem(date: date)
    }


//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let currentDate = (viewController as? ApodViewController)?.date else {
//            return nil
//        }
//        guard let beforeDate = Constants.Calendars.apodCalendar.date(byAdding: .day, value: -1, to: currentDate) else {
//            return nil
//        }
//        let comparison = Constants.Calendars.apodCalendar.compare(Constants.Dates.apodLaunchDate, to: beforeDate, toGranularity: .day)
//        guard comparison == .orderedSame || comparison == .orderedAscending else {
//            return nil
//        }
//        let apodVc = ApodViewController.fromStoryBoard(date: beforeDate)
//        return apodVc
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let currentDate = (viewController as? ApodViewController)?.date else {
//            return nil
//        }
//        guard let afterDate = Constants.Calendars.apodCalendar.date(byAdding: .day, value: 1, to: currentDate) else {
//            return nil
//        }
//        let comparison = Constants.Calendars.apodCalendar.compare(afterDate, to: Date(), toGranularity: .day)
//        guard comparison == .orderedSame || comparison == .orderedAscending else {
//            return nil
//        }
//        let apodVc = ApodViewController.fromStoryBoard(date: afterDate)
//        return apodVc
//    }
}
