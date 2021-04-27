//
//  ApodCell.swift
//  Brahmaand
//
//  Created by jaydeep on 25/04/21.
//

import UIKit

class ApodCell: UICollectionViewCell {

    static let reuseIdentifier = "ApodCell"

    @IBOutlet weak var apodImageView: UIImageView!
    @IBOutlet weak var apodTitleLabel: UILabel!
    @IBOutlet weak var apodDateLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
//        let gradient = CAGradientLayer()
//        gradient.frame = gradientView.bounds
//        gradient.colors = [UIColor.red, UIColor.green]
//        gradient.startPoint = .zero
//        gradient.endPoint = CGPoint(x: 1, y: 1)
//        gradientView.layer.addSublayer(gradient)
        gradientView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }

    var apodTitle: String? {
        didSet {
            apodTitleLabel.text = apodTitle
        }
    }

    var apodDate: Date? {
        didSet {
            apodDateLabel.text = apodDate?.displayFormatted()
        }
    }

    var apodImageUrl: URL? {
        didSet {
            apodImageView.kf.setImage(with: apodImageUrl)
        }
    }
}
