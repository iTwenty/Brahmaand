//
//  ApodFavoritesManager.swift
//  Brahmaand
//
//  Created by jaydeep on 25/04/21.
//

import Foundation

final class ApodFavoritesManager {

    private let apodLocalStorage: ApodLocalStorage
    var onApodAddedToFavorites: ((Date) -> ())?
    var onApodRemovedFromFavorites: ((Date) -> ())?

    init(apodLocalStorage: ApodLocalStorage) {
        self.apodLocalStorage = apodLocalStorage
    }

    func fetchFavoriteApods(completion: @escaping (Result<[Apod], Error>) -> ()) {
        apodLocalStorage.fetchFavoriteApods(completion: completion)
    }

    func addToFavorites(date: Date) -> Bool {
        do {
            try apodLocalStorage.addApodToFavorites(date)
            onApodAddedToFavorites?(date)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func removeFromFavorites(date: Date) -> Bool {
        do {
            try apodLocalStorage.removeApodFromFavorites(date)
            onApodRemovedFromFavorites?(date)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func isFavorited(date: Date, completion: @escaping (Result<Bool, Error>) -> ()) {
        apodLocalStorage.isApodFavorited(date, completion: completion)
    }
}
