import Foundation

public protocol Endpoint {
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: Encodable? { get }
}

extension Endpoint {
    public var host: String {
        ""
    }
    
    public var header: [String: String]? {
        [:]
    }
    
    public var body: Encodable? {
        nil
    }
}

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
