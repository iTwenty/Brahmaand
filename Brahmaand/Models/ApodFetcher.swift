//
//  APODNetwork.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import Foundation

struct FetchOptions: OptionSet {
    let rawValue: Int

    static let localOnly = FetchOptions(rawValue: 1 << 0)
}

protocol ApodFetcher {

    func fetchApod(forDate date: Date, options: FetchOptions?, completion: @escaping (Result<Apod, Error>) -> ())
    func fetchApods(startDate: Date, endDate: Date, options: FetchOptions?, completion: @escaping (Result<[Apod], Error>) -> ())
}
