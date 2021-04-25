//
//  ApodFactory.swift
//  Brahmaand
//
//  Created by jaydeep on 25/04/21.
//

import Foundation

struct ApodFactory {

    private static var apodLocalStorage: ApodLocalStorage? = {
        guard let apodDb = try? SqliteDb(databaseName: "apods", createQueries: ApodLocalStorage.createQueries()) else {
            return nil
        }
        let apodLocalStorage = ApodLocalStorage(db: apodDb)
        return apodLocalStorage
    }()

    private static var apodFavoritesManager: ApodFavoritesManager = ApodFavoritesManager(apodLocalStorage: makeApodLocalStorage())

    // make methods
    static func makeApodLocalStorage() -> ApodLocalStorage {
        guard let storage = apodLocalStorage else {
            fatalError("ApodLocalStorage cannot be created. Cannot continue!")
        }
        return storage
    }

    static func makeApodApiFetcher() -> ApodApiFetcher {
        return ApodApiFetcher()
    }

    static func makeApodFavoritesManager() -> ApodFavoritesManager {
        return apodFavoritesManager
    }
}
