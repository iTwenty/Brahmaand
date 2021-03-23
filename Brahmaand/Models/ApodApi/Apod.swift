//
//  Apod.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import Foundation

enum MediaType: String, Decodable {
    case image, video
}

struct Apod: Decodable, CustomStringConvertible {
    let copyright: String?
    let date: Date
    let explanation: String
    let hdurl: URL?
    let url: URL
    let mediaType: MediaType
    let title: String

    var description: String {
        return "\(date.apodApiFormatted()) : \(title)"
    }
}
