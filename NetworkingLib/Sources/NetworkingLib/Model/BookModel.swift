import Foundation
//
//// MARK: - Welcome7
//struct Welcome7 {
//    let numFound: Int
//    let start: Int
//    let numFoundExact: Bool
//    let docs: [Welcome7Doc]
//    let welcome7NumFound: Int
//    let q: String
//    let offset: NSNull
//}
//
//// MARK: - Welcome7Doc
//struct Welcome7Doc {
//    let key: String
//    let title: String
//    let authorName: [String]?
//    let editions: Editions
//}
//
//// MARK: - Editions
//struct Editions {
//    let numFound: Int
//    let start: Int
//    let numFoundExact: Bool
//    let docs: [EditionsDoc]
//}
//
//// MARK: - EditionsDoc
//struct EditionsDoc {
//    let key: String
//    let title: String
//}
//
//
//public struct Book: Codable {
//public let title: String
//public let authorName: [String]
//public let firstPublishYear: Int?
//public let subject: [String]?
//}
//
//public struct BookSearchResponse: Codable {
//public let docs: [Book]
//}

public struct Books: Decodable {
    
    public let object: [BookObject]
}

public struct Doc: Decodable {
    
    public let titleSuggest: String?
    public let subtitle: String?
    public let authorName: [String]?
    public let firstPublishYear: Int?
    public let coverI: Int?
    public let publisher: [String]?
    public let authorAlternativeName: [String]?
    public let ia: [String]?
}

public struct BookObject: Decodable {
    
    public let start: Int?
    public let numFound: Int?
    public let docs: [Doc]
}

enum CodingKeys: String, CodingKey {
    
    case titleSuggest = "title_suggest"
    case subtitle = "subtitle"
    case authorName = "author_name"
    case firstPublishYear = "first_publish_year"
    case coverI = "cover_i"
    case publisher = "publisher"
    case authorAlternativeName = "author_alternative_name"
    case numFound = "num_found"
}
