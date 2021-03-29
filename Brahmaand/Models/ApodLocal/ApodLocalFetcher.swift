//
//  ApodLocalFetcher.swift
//  Brahmaand
//
//  Created by jaydeep on 29/03/21.
//

import UIKit

fileprivate struct DbInfo {
    static let dbName = "brahmaand"
    static let tableApods = "apods"
    static let tableFavApods = "fav_apods"
    static let colApods_copyright = "copyright"
    static let colApods_date = "date"
    static let colApods_explanation = "explanation"
    static let colApods_hdurl = "hdurl"
    static let colApods_url = "url"
    static let colApods_mediaType = "mediaType"
    static let colApods_title = "title"
}

enum ApodLocalError: Error {
    case noApodError, apodSqlParseError
}

final class ApodLocalFetcher: ApodFetcher {

    private let db: SqliteDb

    init(db: SqliteDb) {
        self.db = db
    }

    @discardableResult func insertApods(apods: [Apod]) -> Bool {
        for apod in apods {
            let insertQuery = """
INSERT OR REPLACE INTO \(DbInfo.tableApods)
(\(DbInfo.colApods_date),
\(DbInfo.colApods_title),
\(DbInfo.colApods_mediaType),
\(DbInfo.colApods_explanation),
\(DbInfo.colApods_url),
\(DbInfo.colApods_hdurl),
\(DbInfo.colApods_copyright)
VALUES (?, ?, ?, ?, ?, ?, ?)
"""
            let params: [Any?] = [apod.date.apodApiFormatted(),
                                  apod.title,
                                  apod.mediaType.rawValue,
                                  apod.explanation,
                                  apod.url,
                                  apod.hdurl,
                                  apod.copyright]
            do {
                try db.insert(insertString: insertQuery, parameters: params)
            } catch {
                print(error)
                return false
            }
        }
        return true
    }

    func fetchApod(forDate date: Date, completion: @escaping (Result<Apod, Error>) -> ()) {
        let fetchQuery = "SELECT * FROM \(DbInfo.tableApods) WHERE \(DbInfo.colApods_date) = ?"
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
        let fetchQuery = "SELECT * FROM \(DbInfo.tableApods) WHERE \(DbInfo.colApods_date) >= ? AND \(DbInfo.colApods_date) <= ?"
        let params = [startDate.apodApiFormatted(), endDate.apodApiFormatted()]
        do {
            let results = try db.fetch(fetchString: fetchQuery, parameters: params)
            let apods = results.compactMap(apod(from:))
            completion(.success(apods))
        } catch {
            completion(.failure(error))
        }
    }

    private func apod(from row: [String: Any]) -> Apod? {
        guard let dateStr = row[DbInfo.colApods_date] as? String,
              let date = Constants.DateFormatters.apodApiFormatter.date(from: dateStr),
              let explanation = row[DbInfo.colApods_explanation] as? String,
              let urlStr = row[DbInfo.colApods_url] as? String,
              let url = URL(string: urlStr),
              let mediaTypeStr = row[DbInfo.colApods_mediaType] as? String,
              let mediaType = MediaType(rawValue: mediaTypeStr),
              let title = row[DbInfo.colApods_title] as? String else {
            return nil
        }
        let copyright = row[DbInfo.colApods_copyright] as? String
        let hdurl = URL(string: row[DbInfo.colApods_hdurl] as? String ?? "")
        return Apod(copyright: copyright, date: date, explanation: explanation,
                    hdurl: hdurl, url: url, mediaType: mediaType, title: title)
    }
}
