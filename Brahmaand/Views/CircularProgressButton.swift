//
//  CircularProgressButton.swift
//  Brahmaand
//
//  Created by Jaydeep Joshi on 01/05/21.
//

import UIKit

enum CircularProgressButtonState {
    case initial
    case progressing(Int)
    case completed
}

class CircularProgressButton: UIView {

    var state: CircularProgressButtonState = .initial {
        didSet {
            update()
        }
    }

    private var outerArc: CAShapeLayer? = nil
    private var innerArc: CAShapeLayer? = nil

    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.pin(to: self)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        state = .initial
    }

    private func update() {

    }
}
