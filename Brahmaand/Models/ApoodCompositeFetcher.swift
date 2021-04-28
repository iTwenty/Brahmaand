//
//  ApoodCompositeFetcher.swift
//  Brahmaand
//
//  Created by jaydeep on 03/04/21.
//

import Foundation

typealias DateRange = (start: Date, end: Date)

/// Denotes a date, and how many days before/after/around that date the fetch must be limited to.
/// Local fetches are always limited to just a single date, denoted by `date` value.
/// The `range` value denotes a range of dates for doing API fetch.
enum FetchType {
    case before(date: Date, days: Int = 30)
    case after(date: Date, days: Int = 30)
    case middle(date: Date, days: Int = 15)
    case single(date: Date)

    var date: Date {
        switch self {
        case .before(let date, _), .after(let date, _), .middle(let date, _), .single(let date):
            return date
        }
    }

    var range: DateRange? {
        switch self {
        case .before(let end, let days):
            if let start = Constants.Calendars.apodCalendar.date(byAdding: .day, value: -days, to: end) {
                return (start, end)
            } else {
                return nil
            }
        case .after(let start, let days):
            if let end = Constants.Calendars.apodCalendar.date(byAdding: .day, value: days, to: start) {
                return (start, end)
            } else {
                return nil
            }
        case .middle(let mid, let days):
            if let start = Constants.Calendars.apodCalendar.date(byAdding: .day, value: -days, to: mid),
               let end = Constants.Calendars.apodCalendar.date(byAdding: .day, value: days, to: mid) {
                return (start, end)
            } else {
                return nil
            }
        case .single(let date):
            return (date, date)
        }
    }
}

struct FetchOptions: OptionSet {
    let rawValue: Int

    static let localOnly = FetchOptions(rawValue: 1 << 0)
}

final class ApodCompositeFetcher {

    private static let apodApiFetcher = ApodFactory.makeApodApiFetcher()
    private static let apodLocalStorage = ApodFactory.makeApodLocalStorage()

    static func fetchApod(fetchType: FetchType, options: FetchOptions?, completion: @escaping (Result<Apod, Error>) -> ()) {
        let date = fetchType.date
        print("Fetching apod for \(date.displayFormatted())...")
        apodLocalStorage.fetchApod(forDate: date) { (localResult) in
            switch localResult {
            case .success:
                print("Fetched apod locally")
                completion(localResult)
            case .failure(let error):
                print("Failed to fetch apod locally : \(error.localizedDescription)")
                if let options = options, options.contains(.localOnly) {
                    print("localOnly option present. Not trying API. Failed to fetch locally")
                    completion(localResult)
                } else if let (start, end) = fetchType.range {
                    print("Trying to fetch apods from \(start) to \(end) from API")
                    apodApiFetcher.fetchApods(startDate: start, endDate: end) { (apiResult) in
                        switch apiResult {
                        case .success(let apods):
                            do {
                                print("Fetched apods from API")
                                try apodLocalStorage.insertApods(apods: apods)
                                print("Saved fetched apods locally")
                                fetchApod(fetchType: fetchType, options: options?.union(.localOnly), completion: completion)
                            } catch {
                                print("Failed to save fetched apods locally")
                                completion(.failure(error))
                            }
                        case .failure(let error):
                            print("Failed to fetch apods from API")
                            completion(.failure(error))
                        }
                    }
                } else {
                    print("Failed to subtract one month from \(date)!!!")
                    completion(.failure("Failed to subtract one month from \(date)!!!"))
                }
            }
        }
    }

    static func fetchApods(startDate: Date, endDate: Date, options: FetchOptions?, completion: @escaping (Result<[Apod], Error>) -> ()) {
        print("Fetching apods from \(startDate) to \(endDate)...")
        apodLocalStorage.fetchApods(startDate: startDate, endDate: endDate) { (localResult) in
            switch localResult {
            case .success(let apods) where !apods.isEmpty:
                print("Fetched apods locally")
                completion(localResult)
            case .success, .failure:
                print("Failed to fetch apods locally, or empty list returned locally")
                if let options = options, options.contains(.localOnly) {
                    print("localOnly option present. Not trying API. Failed to fetch locally")
                    completion(localResult)
                } else {
                    print("Trying to fetch apods from API")
                    apodApiFetcher.fetchApods(startDate: startDate, endDate: endDate) { (apiResult) in
                        switch apiResult {
                        case .success(let apods):
                            do {
                                print("Fetched apods from API")
                                try apodLocalStorage.insertApods(apods: apods)
                                print("Saved fetched apods locally")
                                fetchApods(startDate: startDate, endDate: endDate, options: options?.union(.localOnly), completion: completion)
                            } catch {
                                print("Failed to save fetched apods locally")
                                completion(.failure(error))
                            }
                        case .failure(let error):
                            print("Failed to fetch apods from API")
                            completion(.failure(error))
                        }
                    }
                }
            }
        }
    }
}
