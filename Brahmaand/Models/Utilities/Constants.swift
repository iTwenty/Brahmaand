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

        static let displayDayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            return formatter
        }()

        static let displayMonthFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            return formatter
        }()

        static let displayYearFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            return formatter
        }()
    }

    struct Calendars {

        static let apodCalendar: Calendar = {
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(abbreviation: "PST")!
            return calendar
        }()
    }

    struct Dates {

        static let apodLaunchDate: Date = {
            var components = DateComponents()
            components.year = 1995
            components.month = 6
            components.day = 16
            return Calendars.apodCalendar.date(from: components)!
        }()
    }
}
