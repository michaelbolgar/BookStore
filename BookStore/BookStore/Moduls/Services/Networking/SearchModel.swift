import Foundation

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
