//
//  ApodDateCell.swift
//  Brahmaand
//
//  Created by Jaydeep Joshi on 07/04/21.
//

import UIKit
import Parchment

class ApodDateCell: PagingCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, options: PagingOptions) {
        let dateItem = pagingItem as! PagingDateItem
        self.dayLabel.text = dateItem.dayText
        self.monthLabel.text = dateItem.monthText
        self.yearLabel.text = dateItem.yearText
    }
}
