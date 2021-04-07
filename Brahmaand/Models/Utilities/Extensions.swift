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
