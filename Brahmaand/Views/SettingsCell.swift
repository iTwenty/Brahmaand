//
//  SettingsCell.swift
//  Brahmaand
//
//  Created by jaydeep on 08/05/21.
//

import UIKit

class SettingsCell: UITableViewCell {

    static let reuseId = "SettingsCell"

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        title = nil
        subtitle = nil
    }
}
