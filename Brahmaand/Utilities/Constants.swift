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
            formatter.calendar = Calendars.apodCalendar
            formatter.timeZone = formatter.calendar.timeZone
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()

        static let displayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendars.apodCalendar
            formatter.timeZone = formatter.calendar.timeZone
            formatter.dateFormat = "dd MMM yyyy"
            return formatter
        }()
    }

    struct Calendars {

        static let apodCalendar: Calendar = {
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(abbreviation: "EDT")!
            return calendar
        }()
    }

    struct Dates {

        static let apodLaunchDate: Date = {
            var components = DateComponents()
            components.year = 1995
            components.month = 7
            components.day = 16
            return Calendars.apodCalendar.date(from: components)!
        }()
    }
}
