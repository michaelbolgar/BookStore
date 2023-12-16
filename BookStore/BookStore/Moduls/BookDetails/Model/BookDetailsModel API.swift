import Foundation

//модель для запроса деталей книг 

public struct DetailsModel: Codable {

    let description: Description?
    let key: String?
    let title: String?
    let authors: [Authors]?

    struct Authors: Codable {
        let key: String?
    }

    struct Description: Codable {
        let value: String?
    }
}
