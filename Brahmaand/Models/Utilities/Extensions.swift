//
//  Extensions.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import Foundation

extension Date {

    func apodApiFormatted() -> String {
        return Constants.DateFormatters.apodApiFormatter.string(from: self)
    }
}

// Convenience extension that lets you throw strings as errors
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
