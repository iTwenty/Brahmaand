//
//  ApoodCompositeFetcher.swift
//  Brahmaand
//
//  Created by jaydeep on 03/04/21.
//

import Foundation

final class ApodCompositeFetcher {

    private static let apodApiFetcher: ApodApiFetcher = ApodApiFetcher()
    private static let apodLocalStorage: ApodLocalStorage? = {
        guard let apodDb = try? SqliteDb(databaseName: "apods", createQueries: ApodLocalStorage.createQueries()) else {
            return nil
        }
        let apodLocalStorage = ApodLocalStorage(db: apodDb)
        return apodLocalStorage
    }()

    static func fetchApod(forDate date: Date, options: FetchOptions?, completion: @escaping (Result<Apod, Error>) -> ()) {
        print("Fetching apod for \(date)...")
        apodLocalStorage?.fetchApod(forDate: date, options: options) { (localResult) in
            switch localResult {
            case .success:
                print("Fetched apod locally")
                completion(localResult)
            case .failure(let error):
                print("Failed to fetch apod locally : \(error.localizedDescription)")
                if let options = options, options.contains(.localOnly) {
                    print("localOnly option present. Not trying API. Failed to fetch locally")
                    completion(localResult)
                } else if let startDate = Constants.Calendars.apodCalendar.date(byAdding: .month, value: -1, to: date) {
                    print("Trying to fetch apods from \(startDate) to \(date) from API")
                    apodApiFetcher.fetchApods(startDate: startDate, endDate: date, options: options) { (apiResult) in
                        switch apiResult {
                        case .success(let apods):
                            do {
                                print("Fetched apods from API")
                                try apodLocalStorage?.insertApods(apods: apods)
                                print("Saved fetched apods locally")
                                fetchApod(forDate: date, options: options?.union(.localOnly), completion: completion)
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
        apodLocalStorage?.fetchApods(startDate: startDate, endDate: endDate, options: options) { (localResult) in
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
                    apodApiFetcher.fetchApods(startDate: startDate, endDate: endDate, options: options) { (apiResult) in
                        switch apiResult {
                        case .success(let apods):
                            do {
                                print("Fetched apods from API")
                                try apodLocalStorage?.insertApods(apods: apods)
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
