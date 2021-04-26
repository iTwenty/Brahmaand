//
//  ApodPageViewController.swift
//  Brahmaand
//
//  Created by Jaydeep Joshi on 27/03/21.
//

import UIKit

class ApodPageViewController: UIPageViewController {

    private lazy var apodDatePickerView: UIDatePicker = {
        let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.datePickerMode = .date
        view.calendar = Constants.Calendars.apodCalendar
        view.minimumDate = Constants.Dates.apodLaunchDate
        view.maximumDate = Date()
        if #available(iOS 13.4, *) {
            view.preferredDatePickerStyle = .wheels
        }
        return view
    }()

    private lazy var apodDatePickerToolbar: UIToolbar = {
        // Give the toolbar 100x100 rect to begin with, or else it throws all sorts of autolayout constraint errors
        // when trying to lay out the buttons.
        let bar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        bar.translatesAutoresizingMaskIntoConstraints = false
        let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(didClickTodayButton(_:)))
        let flexiSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didClickDoneButton(_:)))
        bar.items = [todayButton, flexiSpace, doneButton]
        bar.sizeToFit()
        return bar
    }()

    private lazy var apodDateTitleButton: InputButton = {
        let button = InputButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didClickApodDateTitleButton(_:)), for: .touchUpInside)
        button.inputView = apodDatePickerView
        button.inputAccessoryView = apodDatePickerToolbar
        return button
    }()

    private lazy var favoriteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(didClickFavoriteButton(_:)))
        return button
    }()

    private var currentShownApodDate = Date() {
        didSet {
            apodDateTitleButton.setTitle(currentShownApodDate.displayFormatted(), for: .normal)
        }
    }

    private var isCurrentShownApodFavorited: Bool? {
        didSet {
            guard let value = isCurrentShownApodFavorited else {
                navigationItem.rightBarButtonItem = nil
                return
            }
            navigationItem.rightBarButtonItem = favoriteButton
            favoriteButton.image = value ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        }
    }

    private let apodFavoritesManager = ApodFactory.makeApodFavoritesManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        let apodVc = ApodContainerViewController(fetchType: .before(date: currentShownApodDate))
        setViewControllers([apodVc], direction: .reverse, animated: false, completion: nil)
        navigationItem.titleView = apodDateTitleButton
        navigationItem.rightBarButtonItem = favoriteButton
        apodDateTitleButton.setTitle(currentShownApodDate.displayFormatted(), for: .normal)
        updateFavorite()
    }

    @IBAction func didClickApodDateTitleButton(_ sender: Any) {
        apodDateTitleButton.becomeFirstResponder()
        apodDatePickerView.setDate(currentShownApodDate, animated: false)
    }

    @objc func didClickTodayButton(_ sender: Any) {
        if let maxDate = apodDatePickerView.maximumDate {
            apodDatePickerView.setDate(maxDate, animated: false)
        }
    }

    @objc func didClickDoneButton(_ sender: Any) {
        apodDateTitleButton.resignFirstResponder()
        let selectedDate = self.apodDatePickerView.date
        if currentShownApodDate != selectedDate {
            let direction: UIPageViewController.NavigationDirection = currentShownApodDate > selectedDate ? .reverse : .forward
            let apodVc = ApodContainerViewController(fetchType: .middle(date: selectedDate))
            setViewControllers([apodVc], direction: direction, animated: true, completion: nil)
            currentShownApodDate = selectedDate
            updateFavorite()
        }
    }

    @objc func didClickFavoriteButton(_ sender: Any) {
        guard let favorited = isCurrentShownApodFavorited else { return }
        var success = false
        if favorited {
            success = apodFavoritesManager.removeFromFavorites(date: currentShownApodDate)
        } else {
            success = apodFavoritesManager.addToFavorites(date: currentShownApodDate)
        }
        if success {
            isCurrentShownApodFavorited?.toggle()
        } else {
            print("Failed to (un)favorite apod for date \(currentShownApodDate.displayFormatted())")
        }
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
        let apodVc = ApodContainerViewController(fetchType: .before(date: beforeDate))
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
        let apodVc = ApodContainerViewController(fetchType: .after(date: afterDate))
        return apodVc
    }

    private func updateFavorite() {
        apodFavoritesManager.isFavorited(date: currentShownApodDate) { [weak self] (result) in
            switch result {
            case .success(let favorited):
                self?.isCurrentShownApodFavorited = favorited
            case .failure(let error):
                print(error.localizedDescription)
                self?.isCurrentShownApodFavorited = nil
            }
        }
    }
}

extension ApodPageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let date = (pageViewController.viewControllers?.first as? ApodContainerViewController)?.fetchType.date else {
            return
        }
        currentShownApodDate = date
        updateFavorite()
    }
}
