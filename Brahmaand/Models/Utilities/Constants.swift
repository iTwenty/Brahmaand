//
//  Constants.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import Foundation

struct Constants {

    struct DateFormatters {

        static let apodApiFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    }
}
