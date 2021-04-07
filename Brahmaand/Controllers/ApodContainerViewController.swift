//
//  ApodContainerViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 07/04/21.
//

import UIKit

class ApodContainerViewController: UIViewController {

    @IBOutlet weak var timelineView: UICollectionView!
    @IBOutlet weak var apodPageContainerView: UIView!

    var days: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        timelineView.dataSource = self
        timelineView.delegate = self
        timelineView.register(UINib(nibName: "ApodDateCell", bundle: nil), forCellWithReuseIdentifier: ApodDateCell.reuseId)
        days = Constants.Calendars.apodCalendar.dateComponents([.day], from: Constants.Dates.apodLaunchDate, to: Date()).day!
    }
}

extension ApodContainerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let apodDateCell = collectionView.dequeueReusableCell(withReuseIdentifier: ApodDateCell.reuseId, for: indexPath) as! ApodDateCell
        let date = Constants.Calendars.apodCalendar.date(byAdding: .day, value: indexPath.row, to: Constants.Dates.apodLaunchDate)!
        apodDateCell.dateLabel.text = Constants.DateFormatters.apodApiFormatter.string(from: date)
        return apodDateCell
    }
}

extension ApodContainerViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 32, height: 32)
    }
}
