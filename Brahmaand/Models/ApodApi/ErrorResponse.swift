//
//  ErrorResponse.swift
//  Brahmaand
//
//  Created by jaydeep on 24/03/21.
//

import Foundation

struct ErrorResponse: Decodable, CustomStringConvertible {
    let code: Int
    let msg: String

    var description: String {
        "\(code) : \(msg)"
    }
}
