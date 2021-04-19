//
//  ApodGridViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import UIKit

class ApodContentViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var apodMediaView: ApodMediaView!
    @IBOutlet weak var apodTitleLabel: UILabel!
    @IBOutlet weak var apodDateButton: InputButton!
    @IBOutlet weak var apodExplanationTextView: UITextView!

    @IBOutlet weak var apodMediaViewHeightConstraint: NSLayoutConstraint!

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
        view.addTarget(self, action: #selector(didSelectApodDate(_:)), for: .valueChanged)
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

    var apod: Apod?
    var dateSelectAction: ((Date, UIPageViewController.NavigationDirection) -> ())?

    static func fromStoryBoard(apod: Apod, dateSelectAction: ((Date, UIPageViewController.NavigationDirection) -> ())?) -> ApodContentViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc: ApodContentViewController = sb.instantiateViewController(identifier: "ApodContentViewController")
        vc.apod = apod
        vc.dateSelectAction = dateSelectAction
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        showApod()
    }

    private func setupViews() {
        apodTitleLabel.text = nil
        apodExplanationTextView.text = nil
        apodDateButton.setTitle(nil, for: .normal)
        apodDateButton.inputView = apodDatePickerView
        apodDateButton.inputAccessoryView = apodDatePickerToolbar
        apodMediaView.imageTapAction = { [weak self] in
            self?.showFullScreenImage()
        }
    }

    private func showApod() {
        guard let apod = apod else { return }
        apodTitleLabel.text = apod.title
        apodDateButton.setTitle(apod.date.displayFormatted(), for: .normal)
        apodExplanationTextView.text = apod.explanation
        switch apod.mediaType {
        case .image:
            self.loadImage(url: apod.url)
        case .video:
            self.loadVideo(url: apod.url)
        }
    }

    private func loadImage(url: URL) {
        self.apodMediaView.loadImage(url: url) {
            self.apodMediaViewHeightConstraint.isActive = false
        }
    }

    private func loadVideo(url: URL) {
        self.apodMediaViewHeightConstraint.isActive = true
        guard let host = url.host else { return }
        if host.contains("youtube") {
            let videoCode = url.lastPathComponent
            self.apodMediaView.loadYoutubeVideo(videoCode: videoCode)
        } else {
            // TODO some other video site. load in wkwebview??
        }
    }

    private func showFullScreenImage() {
        guard let apod = apod else { return }
        ApodNavigator.shared.showFullScreenImage(apod: apod, presenter: self)
    }

    @IBAction func didClickApodDateButton(_ sender: Any) {
        self.apodDateButton.becomeFirstResponder()
        if let date = apod?.date {
            self.apodDatePickerView.setDate(date, animated: false)
        }
    }

    @objc func didSelectApodDate(_ sender: Any) {
        print(self.apodDatePickerView.date.displayFormatted())
    }

    @objc func didClickTodayButton(_ sender: Any) {
        if let maxDate = apodDatePickerView.maximumDate {
            apodDatePickerView.setDate(maxDate, animated: false)
        }
    }

    @objc func didClickDoneButton(_ sender: Any) {
        guard let date = apod?.date else { return }
        self.apodDateButton.resignFirstResponder()
        let selectedDate = self.apodDatePickerView.date
        if date != selectedDate {
            let direction: UIPageViewController.NavigationDirection = date > selectedDate ? .reverse : .forward
            self.dateSelectAction?(self.apodDatePickerView.date, direction)
        }
    }

    private func setBackgroundColor(fromImage image: UIImage) {
        image.getColors { [weak self] (colors) in
            guard let colors = colors else { return }
            UIView.animate(withDuration: 0.1) {
                self?.view.backgroundColor = colors.background
                self?.apodTitleLabel.textColor = colors.primary
                self?.apodExplanationTextView.textColor = colors.detail
            }
        }
    }
}
