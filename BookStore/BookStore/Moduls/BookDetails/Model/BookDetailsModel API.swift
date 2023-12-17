import Foundation

//модель для запроса деталей книг 

public struct DetailsModel: Codable {
    
    let description: Description?
    let key: String?
    let title: String?
    let authors: [Authors]?
    var rating: Rating?
    
    struct Authors: Codable {
        let key: String?
    }
    
    struct Description: Codable {
        let value: String?
    }
    
    struct Rating: Codable {
        var summary: Summary?
        
        struct Summary: Codable {
            var average: Double?
            let count: Int?
            let sortable: Double?
        }
    }
}
//
//            enum CodingKeys: String, CodingKey {
//                case summary
//            }
//            
//            init(from decoder: Decoder) throws {
//                let container = try decoder.container(keyedBy: CodingKeys.self)
//                summary = try container.decodeIfPresent(Summary.self, forKey: .summary)
//            }
//        }
//    }

