//
//  ApodLocalFetcher.swift
//  Brahmaand
//
//  Created by jaydeep on 29/03/21.
//

import UIKit

fileprivate struct DbInfo {
    static let name = "brahmaand"

    struct TableApods {
        static let name = "apods"
        static let col_copyright = "copyright"
        static let col_date = "date"
        static let col_explanation = "explanation"
        static let col_hdurl = "hdurl"
        static let col_url = "url"
        static let col_mediaType = "mediaType"
        static let col_title = "title"
    }

    struct TableFavApods {
        static let name = "fav_apods"
        static let col_apod_date = "apod_date"
    }
}

enum ApodLocalError: Error {
    case noApodError, apodSqlParseError
}

final class ApodLocalStorage: ApodFetcher {

    private let db: SqliteDb

    init(db: SqliteDb) {
        self.db = db
    }

    func insertApods(apods: [Apod]) throws {
        for apod in apods {
            let insertQuery = """
INSERT OR IGNORE INTO \(DbInfo.TableApods.name)
(\(DbInfo.TableApods.col_date),
\(DbInfo.TableApods.col_title),
\(DbInfo.TableApods.col_mediaType),
\(DbInfo.TableApods.col_explanation),
\(DbInfo.TableApods.col_url),
\(DbInfo.TableApods.col_hdurl),
\(DbInfo.TableApods.col_copyright))
VALUES (?, ?, ?, ?, ?, ?, ?)
"""
            let params: [Any?] = [apod.date.apodApiFormatted(),
                                  apod.title,
                                  apod.mediaType.rawValue,
                                  apod.explanation,
                                  apod.url.absoluteString,
                                  apod.hdurl?.absoluteString,
                                  apod.copyright]
            try db.insert(insertString: insertQuery, parameters: params)
        }
    }

    func fetchApod(forDate date: Date, completion: @escaping (Result<Apod, Error>) -> ()) {
        let fetchQuery = "SELECT * FROM \(DbInfo.TableApods.name) WHERE \(DbInfo.TableApods.col_date) = ?"
        let params = [date.apodApiFormatted()]
        do {
            let results = try db.fetch(fetchString: fetchQuery, parameters: params)
            guard let apodRow = results.first else {
                throw ApodLocalError.noApodError
            }
            guard let apod = self.apod(from: apodRow) else {
                throw ApodLocalError.apodSqlParseError
            }
            completion(.success(apod))
        } catch {
            completion(.failure(error))
        }
    }

    func fetchApods(startDate: Date, endDate: Date, completion: @escaping (Result<[Apod], Error>) -> ()) {
        let fetchQuery = "SELECT * FROM \(DbInfo.TableApods.name) WHERE \(DbInfo.TableApods.col_date) >= ? AND \(DbInfo.TableApods.col_date) <= ?"
        let params = [startDate.apodApiFormatted(), endDate.apodApiFormatted()]
        do {
            let results = try db.fetch(fetchString: fetchQuery, parameters: params)
            let apods = results.compactMap(apod(from:))
            completion(.success(apods))
        } catch {
            completion(.failure(error))
        }
    }

    func addApodToFavorites(_ date: Date) throws {
        let insertQuery = """
INSERT OR IGNORE INTO \(DbInfo.TableFavApods.name)
(\(DbInfo.TableFavApods.col_apod_date))
VALUES (?)
"""
        let params: [Any?] = [date.apodApiFormatted()]
        try db.insert(insertString: insertQuery, parameters: params)
    }

    func removeApodFromFavorites(_ date: Date) throws {
        let deleteQuery = """
DELETE FROM \(DbInfo.TableFavApods.name) WHERE \(DbInfo.TableFavApods.col_apod_date) = ?
"""
        let params: [Any?] = [date.apodApiFormatted()]
        try db.insert(insertString: deleteQuery, parameters: params)
    }

    func fetchFavoriteApods(completion: @escaping (Result<[Apod], Error>) -> ()) {
        let fetchQuery = "SELECT * FROM \(DbInfo.TableApods.name) INNER JOIN \(DbInfo.TableFavApods.name) ON \(DbInfo.TableApods.col_date) = \(DbInfo.TableFavApods.col_apod_date) ORDER BY \(DbInfo.TableFavApods.col_apod_date) ASC"
        do {
            let results = try db.fetch(fetchString: fetchQuery, parameters: [])
            let apods = results.compactMap(apod(from:))
            completion(.success(apods))
        } catch {
            completion(.failure(error))
        }
    }

    func isApodFavorited(_ date: Date, completion:  @escaping (Result<Bool, Error>) -> ()) {
        let fetchKey = "EXISTS (SELECT 1 FROM \(DbInfo.TableFavApods.name) WHERE \(DbInfo.TableFavApods.col_apod_date) = ? LIMIT 1)"
        let fetchQuery = "SELECT \(fetchKey)"
        let params = [date.apodApiFormatted()]
        do {
            let results = try db.fetch(fetchString: fetchQuery, parameters: params)
            guard let existsRow = results.first else {
                throw "EXISTS returned no row. That's impossible!"
            }
            guard let exists = existsRow[fetchKey] as? Int else {
                throw "EXISTS did not return 1/0. That's impossible!"
            }
            completion(.success(exists == 0 ? false : true))
        } catch {
            completion(.failure(error))
        }
    }

    private func apod(from row: [String: Any]) -> Apod? {
        guard let dateStr = row[DbInfo.TableApods.col_date] as? String,
              let date = Constants.DateFormatters.apodApiFormatter.date(from: dateStr),
              let explanation = row[DbInfo.TableApods.col_explanation] as? String,
              let urlStr = row[DbInfo.TableApods.col_url] as? String,
              let url = URL(string: urlStr),
              let mediaTypeStr = row[DbInfo.TableApods.col_mediaType] as? String,
              let mediaType = MediaType(rawValue: mediaTypeStr),
              let title = row[DbInfo.TableApods.col_title] as? String else {
            return nil
        }
        let copyright = row[DbInfo.TableApods.col_copyright] as? String
        let hdurl = URL(string: row[DbInfo.TableApods.col_hdurl] as? String ?? "")
        return Apod(copyright: copyright, date: date, explanation: explanation,
                    hdurl: hdurl, url: url, mediaType: mediaType, title: title)
    }

    static func createQueries() -> [String] {
        let foreignKeysQuery = "PRAGMA foreign_keys = ON"

        let createTableApodsQuery = """
CREATE TABLE \(DbInfo.TableApods.name) (
\(DbInfo.TableApods.col_date) TEXT PRIMARY KEY,
\(DbInfo.TableApods.col_title) TEXT NOT NULL,
\(DbInfo.TableApods.col_explanation) TEXT NOT NULL,
\(DbInfo.TableApods.col_url) TEXT NOT NULL,
\(DbInfo.TableApods.col_mediaType) TEXT NOT NULL,
\(DbInfo.TableApods.col_copyright) TEXT,
\(DbInfo.TableApods.col_hdurl) TEXT)
"""

        let createTableFavApodsQuery = """
CREATE TABLE \(DbInfo.TableFavApods.name) (
\(DbInfo.TableFavApods.col_apod_date) TEXT PRIMARY KEY,
FOREIGN KEY(\(DbInfo.TableFavApods.col_apod_date)) REFERENCES \(DbInfo.TableApods.name)(\(DbInfo.TableApods.col_date)))
"""
        return [foreignKeysQuery, createTableApodsQuery, createTableFavApodsQuery]
    }

    func removeData() {
        do {
            try self.db.destroyStorage()
        } catch {
            print("Failed to remove local apod data : \(error.localizedDescription)")
        }
    }
}
