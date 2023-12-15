import UIKit

struct CategoriesModel {
    let image: UIImage?
    let genre: String?
    let name: String?
    let author: String?
    
    let categoriesName = ["Love", "Fiction", "Horror", "Crime", "Drama", "Classics", "Children", "Sci-fi", "Humor", "Poetry", "History of art design styles", "History", "Biography", "Business"]
    let category: [String: Categories] = ["Love": .love, "Fiction": .fiction, "Horror": .horror, "Crime": .crime, "Drama": .drama, "Classics": .classics, "Children": .forChildren, "Sci-fi": .sci_fi, "Humor": .humor, "Poetry": .poetry, "History of art design styles": .art, "History": .history, "Biography": .biography, "Business": .business]
    
    init(image: UIImage, genre: String, name: String, author: String) {
        self.image = image
        self.genre = genre
        self.name = name
        self.author = author
    }
    
    init() {
        self.image = nil
        self.genre = nil
        self.name = nil
        self.author = nil
    }
}
