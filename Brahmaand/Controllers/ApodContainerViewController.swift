//
//  ApodContainerViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 07/04/21.
//

import UIKit

class ApodContainerViewController: UIViewController {

    @IBOutlet weak var apodPageContainerView: UIView!

    var days: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        days = Constants.Calendars.apodCalendar.dateComponents([.day], from: Constants.Dates.apodLaunchDate, to: Date()).day!
    }
}
