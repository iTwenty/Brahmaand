//
//  ApodGridViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import UIKit
import Kingfisher

extension UIActivityIndicatorView : Placeholder {}

class ApodViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var apodMediaView: ApodMediaView!
    @IBOutlet weak var apodTitleLabel: UILabel!
    @IBOutlet weak var apodDateButton: InputButton!
    @IBOutlet weak var apodExplanationTextView: UITextView!

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

    var date: Date?
    var didSelectDate: ((Date, UIPageViewController.NavigationDirection) -> ())?

    static func fromStoryBoard(date: Date, didSelectDate: ((Date, UIPageViewController.NavigationDirection) -> ())?) -> ApodViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc: ApodViewController = sb.instantiateViewController(identifier: "ApodViewController")
        vc.date = date
        vc.didSelectDate = didSelectDate
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        resetViews()
        self.fetchApod()
    }

    private func resetViews() {
        self.apodTitleLabel.text = nil
        self.apodExplanationTextView.text = nil
        self.apodDateButton.setTitle(nil, for: .normal)
        self.apodDateButton.inputView = self.apodDatePickerView
        self.apodDateButton.inputAccessoryView = self.apodDatePickerToolbar
    }

    private func fetchApod() {
        guard let date = date else { return }
        ApodCompositeFetcher.fetchApod(forDate: date, options: nil) { (result) in
            switch result {
            case .success(let apod):
                DispatchQueue.main.async {
                    self.showApod(apod)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func showApod(_ apod: Apod) {
        self.apodTitleLabel.text = apod.title
        self.apodDateButton.setTitle(apod.date.displayFormatted(), for: .normal)
        self.apodExplanationTextView.text = apod.explanation
        switch apod.mediaType {
        case .image:
            self.loadImage(url: apod.url)
        case .video:
            self.loadVideo(url: apod.url)
        }
    }

    private func loadImage(url: URL) {
        self.apodMediaView.loadImage(url: url)
    }

    private func loadVideo(url: URL) {
        guard let host = url.host else { return }
        if host.contains("youtube") {
            let videoCode = url.lastPathComponent
            let imgUrlString = "https://img.youtube.com/vi/\(videoCode)/maxresdefault.jpg"
            guard let imgUrl = URL(string: imgUrlString) else { return }
            loadImage(url: imgUrl)
        } else {
            // TODO some other video site. load in wkwebview??
        }
    }

    @IBAction func didClickApodDateButton(_ sender: Any) {
        self.apodDateButton.becomeFirstResponder()
        if let date = self.date {
            self.apodDatePickerView.setDate(date, animated: false)
        }
    }

    @objc func didSelectApodDate(_ sender: Any) {
        print(self.apodDatePickerView.date.displayFormatted())
    }

    @objc func didClickTodayButton(_ sender: Any) {
        apodDatePickerView.setDate(apodDatePickerView.maximumDate!, animated: false)
    }

    @objc func didClickDoneButton(_ sender: Any) {
        guard let date = self.date else { return }
        self.apodDateButton.resignFirstResponder()
        let selectedDate = self.apodDatePickerView.date
        if date != selectedDate {
            let direction: UIPageViewController.NavigationDirection = date > selectedDate ? .reverse : .forward
            self.didSelectDate?(self.apodDatePickerView.date, direction)
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
