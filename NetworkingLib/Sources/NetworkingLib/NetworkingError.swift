import Foundation

public enum NetworkingError: Error {
    
    case decode
    case custom(String)
    
    var title: String {
        switch self {
        case .decode: return "Fail of parsing data"
        case .custom(let title): return title
        }
    }
}
