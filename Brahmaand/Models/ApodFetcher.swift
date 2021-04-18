//
//  APODNetwork.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import Foundation

protocol ApodFetcher {

    func fetchApod(forDate date: Date, completion: @escaping (Result<Apod, Error>) -> ())
    func fetchApods(startDate: Date, endDate: Date, completion: @escaping (Result<[Apod], Error>) -> ())
}
