//
//  CircularProgressButton.swift
//  Brahmaand
//
//  Created by Jaydeep Joshi on 01/05/21.
//

import UIKit

enum CircularProgressButtonState {
    case initial
    case progressing(Float)
    case completed
}

class CircularProgressButton: UIView {

    private static let transitionDuration = 0.25 // seconds

    var state: CircularProgressButtonState = .initial {
        didSet {
            updateState(oldState: oldValue)
        }
    }

    private let outerArc = CAShapeLayer()
    private let innerArc = CAShapeLayer()

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
        outerArc.frame = frame
        outerArc.fillColor = nil
        outerArc.lineWidth = 1
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2.0 * CGFloat.pi
        let clockwise = true
        let center = outerArc.position
        let outerArcRadius = outerArc.bounds.size.width / 2.0
        let outerArcPath = UIBezierPath(arcCenter: center, radius: outerArcRadius,
                                        startAngle: startAngle, endAngle: endAngle,
                                        clockwise: clockwise)
        outerArc.path = outerArcPath.cgPath

        innerArc.frame = frame
        innerArc.fillColor = nil
        innerArc.lineWidth = 3
        let innerArcRadius = outerArcRadius - (outerArc.lineWidth * 2)
        let innerArcPath = UIBezierPath(arcCenter: center, radius: innerArcRadius,
                                        startAngle: startAngle, endAngle: endAngle,
                                        clockwise: clockwise)
        innerArc.path = innerArcPath.cgPath

        state = .initial
    }

    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvents)
    }

    private func updateState(oldState: CircularProgressButtonState) {
        switch state {
        case .initial:
            let downloadImage = UIImage(systemName: "arrow.down.to.line")
            button.setImage(downloadImage, for: .normal)
            outerArc.removeFromSuperlayer()
            innerArc.removeFromSuperlayer()
        case .progressing(let progress):
            if case .progressing = oldState {
                innerArc.strokeEnd = CGFloat(progress)
            } else {
                let cancelImage = UIImage(systemName: "xmark.circle.fill")
                button.setImage(cancelImage, for: .normal)
                outerArc.strokeStart = 0
                innerArc.strokeStart = 0
                outerArc.strokeEnd = 1
                innerArc.strokeEnd = 0
                layer.addSublayer(outerArc)
                layer.addSublayer(innerArc)
            }
        case .completed:
            let completedImage = UIImage(systemName: "checkmark.circle.fill")
            button.setImage(completedImage, for: .normal)
            outerArc.removeFromSuperlayer()
            innerArc.removeFromSuperlayer()
        }
    }
}
