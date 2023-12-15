import Foundation

struct CategoryList: Codable {
    var categories: [[String]: [[BookData]]]

    struct BookData: Codable {
        let key: String
        let title: String?
    }

//    init (categories: [[String]: [[String]]]) {
//        self.categories = categories
//    }
}

struct DetailBook {
    var details: [[String]: [[String]]]

    init (details: [[String]: [[String]]]) {
        self.details = details
    }
}

struct TopTrends {
    var trends: [[String]: [[String]]]

    init (trends: [[String]: [[String]]]) {
        self.trends = trends
    }
}

struct SearchBooks {
    var result: [[String]: [[String]]]

    init (result: [[String]: [[String]]]) {
        self.result = result
    }
}
