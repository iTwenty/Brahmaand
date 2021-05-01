//
//  Extensions.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import Foundation
import UIKit

extension Date {

    func apodApiFormatted() -> String {
        return Constants.DateFormatters.apodApiFormatter.string(from: self)
    }

    func displayFormatted() -> String {
        return Constants.DateFormatters.displayFormatter.string(from: self)
    }
}

// Convenience extension that lets you throw strings as errors
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

extension UIImage {
    func resized(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIView {
    func pin(to view: UIView, useSafeArea: Bool = false) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        let leadingAnchor = useSafeArea ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor
        let topAnchor = useSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
        let trailingAnchor = useSafeArea ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor
        let bottomAnchor = useSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor
        NSLayoutConstraint .activate([
            self.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.topAnchor.constraint(equalTo: topAnchor),
            self.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
