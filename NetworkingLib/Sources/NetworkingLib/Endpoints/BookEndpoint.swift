import Foundation

public enum CoinEndpoint {
    case book(keyword: String)
}

extension CoinEndpoint: Endpoint {
    
    public var host: String {
        return "openlibrary.org"
    }
    
    public var path: String {
        switch self {
        case .book:
            return "search.json"
        }
    }
    
    public var queryItems: [URLQueryItem]? {
        var queryItems: [URLQueryItem]?
        switch self {
        case .book(let keyword):
            queryItems = [
                URLQueryItem(name: "q", value: keyword),
            ]
        }
        return queryItems
    }
    
    public var method: RequestMethod {
        switch self {
        case .book:
            return .get
        }
    }
}
