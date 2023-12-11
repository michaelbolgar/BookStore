//
//  TrendingBooks Model.swift
//  BookStore
//
//  Created by Михаил Болгар on 11.12.2023.
//

import Foundation

public struct TrendingBooks: Codable {
    let query: String
    let works: [Book]

    struct Book: Codable {
        let key: String?
        let title: String?
        let first_publish_year: Int?
        let has_fulltext: Bool?
        let ia: [String]?
        let ia_collection_s: String?
        let cover_edition_key: String?
        let cover_i: Int?
        let author_key: [String]?
        let author_name: [String]?
    }
}
