//
//  SearchRequestDTO.swift
//  iTunes2
//
//  Created by Vinicius Albino on 19/08/23.
//

import Foundation

enum MediaType: String, Mappable {
    case movie
    case music
    case audiobook
    case podcast
}

struct SearchRequestDTO: Mappable {
    var term: String
    var media: MediaType
    var limit: Int
    var offset: Int
    
    var asDictionary: [String: String] {
        return [
            "term": term,
            "media": media.rawValue,
            "limit": "\(limit)",
            "offset": "\(offset)"
        ]
    }
}
