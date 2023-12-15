import UIKit

protocol NetworkingManagerProtocol {

    func getCategories(for category: String) async throws -> CategoryCollection
//    func getBookDetails(for id: String) async throws -> DetailBook
//    func getTrends(for period: TrendingPeriod) async throws -> TopTrends
//    func getSearchQuery(for search: String) async throws -> SearchBooks

}

enum TrendingPeriod: String {
    case weekly = "weekly"
    case monthly = "monthly"
    case yearly = "yearly"
}

enum Categories: String {
    case love = "love"
    case fiction = "fiction"
    case horror = "horror"
    case crime = "crime"
    case drama = "drama"
    case classics = "classics"
    case forChildren = "children"
    case sci_fi = "sci-fi"
    case humor = "humor"
    case poetry = "poetry"
    case art = "history_of_art__art__design_styles"
    case history = "history"
    case biography = "biography"
    case business = "business"
    case fantasy = "fantasy"
}

//https://openlibrary.org/subjects/\(category.rawValue).json
//https://openlibrary.org/trending/\(period.rawValue).json
//https://openlibrary.org/search.json?q=" + "\(keyword)


enum Endpoint {

    case getSearchQuery(String)
    case getCategories(String)
    case getBookDetails(String)
    case getTrends(String)

    var path: String {
        switch self {
        case.getSearchQuery(_):
            return "/search.json"
        case .getCategories(let category):
            return "/subjects/\(category).json"
        case .getBookDetails(let key):
            return "\(key).json"
        case .getTrends(let period):
            return "/trending/\(period).json"
        }
    }
}

public class NetworkingManager {

    static let instance = NetworkingManager()

    var searchCompletion: ((BookObject) -> Void)?
    var timer: Timer?

    var urlEndpoints = [("&mode=everything", false),
                       ("&sort=editions&mode=everything", false),
                       ("&sort=old&mode=everything", false),
                       ("&sort=new&mode=everything", false),
                       ("https://openlibrary.org/search.json?title=", true),
                       ("https://openlibrary.org/search.json?author=", true)]

    func importJson(url: String, completion: @escaping (BookObject) -> Void) {

        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        guard let data = data else { return }
            do {
                let object = try JSONDecoder().decode(BookObject.self, from: data)
                DispatchQueue.main.async {
                    completion(object)
                }
            } catch {
                print(error)
            }
        }).resume()
    }

    func getUrl(rawUrl: String) -> String {
        let url = rawUrl.replacingOccurrences(of: " ", with: "+")
        return url
    }

    //моя
    private func createURL(for endpoint: Endpoint, with query: String?) -> URL? {

        var components = URLComponents()
        components.scheme = "https"
        components.host = "openlibrary.org"
        components.path = endpoint.path

        components.queryItems = makeParameters(for: endpoint, with: query).compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        return components.url
    }

    //моя
    private func makeParameters (for endpoint: Endpoint, with query: String?) -> [String: String] {
        var parameters: [String: String] = [:]

        switch endpoint {
        case.getTrends(_):
            parameters["fields"] = "*,availability"
            parameters["limit"] = "10"

        case.getSearchQuery(_):
            if let query = query {
                parameters["q"] = "\(query)"
                parameters["fields"] = "*,availability"
                parameters["limit"] = "10"
            }

        default:
            break
        }
        return parameters
    }

    //моя
    private func getPosts(endpoint: Endpoint, with query: String?) async throws -> Data {
        guard let url = createURL(for: endpoint, with: query) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            throw error
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = url.absoluteString

            let (data, respose) = try await URLSession.shared.data(for: request)
            print ("Request: - \(request)")

            guard let httpResponse = respose as? HTTPURLResponse else { throw NSError(domain: "Invalid URL", code: 0, userInfo: nil) }
            print ("Response status code: \(httpResponse.statusCode)")

            return data
        } catch {
            print (error.localizedDescription)
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
    }

    public func searchBooks(keyword: String, emptyCompletion: () -> Void, searchCompletion: @escaping (BookObject) -> Void) {
        timer?.invalidate()
        self.searchCompletion = searchCompletion
        if keyword.isEmpty {
            emptyCompletion()
            return
        }
        var url = "https://openlibrary.org/search.json?q=" + "\(keyword)"

        for (i,c) in urlEndpoints.enumerated(){
            if(UserDefaults.standard.bool(forKey: "\(i)") == true){
                if(c.1 == false){
                    url = url + c.0
                }else{
                    url = c.0 + "\(keyword)"
                }
            }
        }
        let passData = (url: url, completion: searchCompletion)
        timer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(startSearching), userInfo: url, repeats: false)
    }

    @objc func startSearching() {
        let url = timer!.userInfo as! String
        let finalUrl = getUrl(rawUrl: url)
        guard let completion = searchCompletion else { return }
        importJson(url: finalUrl, completion: completion)
    }

    // getting top books
    func getTrendingBooks(for period: TrendingPeriod, completion: @escaping (Result<[TrendingBooks.Book], Error>) -> Void) {
        let trendingURL = "https://openlibrary.org/trending/\(period.rawValue).json"

        guard let url = URL(string: trendingURL) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "No data", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            do {
                let trendingBooks = try JSONDecoder().decode(TrendingBooks.self, from: data)
                let books = trendingBooks.works.compactMap { $0 }
                completion(.success(books))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    //getting categories collection
    func getCategoryCollection(for category: Categories, completion: @escaping (Result<[CategoryCollection], Error>) -> Void) {
        let trendingURL = "https://openlibrary.org/subjects/\(category.rawValue).json"

        guard let url = URL(string: trendingURL) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "No data", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            //где-то здесь кажется есть лишний код
            do {
                let jsonDecoder = JSONDecoder()

                // Попытка декодировать массив SubjectResponse
                if let subjectsResponse = try? jsonDecoder.decode([CategoryCollection].self, from: data) {
                    completion(.success(subjectsResponse))
                    return
                }

                // Если декодирование массива не удалось, попробуем декодировать как одиночный объект SubjectResponse
                if let singleSubjectResponse = try? jsonDecoder.decode(CategoryCollection.self, from: data) {
                    completion(.success([singleSubjectResponse]))
                } else {
                    // Если не удалось декодировать как массив или объект, возвращаем ошибку
                    let error = NSError(domain: "Invalid Response", code: 0, userInfo: nil)
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

extension NetworkingManager: NetworkingManagerProtocol {
    func getCategories(for category: String) async throws -> CategoryCollection {
        let data = try await getPosts(endpoint: .getCategories(category), with: category)
        let decodedData = try decodeJSON(type: CategoryCollection.self, from: data)
        return decodedData
    }

//    func getBookDetails(for id: String) async throws -> DetailBook {
//    }
//
//    func getTrends(for period: TrendingPeriod) async throws -> TopTrends {
//        <#code#>
//    }
//
//    func getSearchQuery(for search: String) async throws -> SearchBooks {
//
//    }

    func decodeJSON<T: Decodable>(type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print ("Failed to decode JSON", jsonError)
            throw jsonError
        }
    }

}

// MARK: - Welcome10
struct Welcome10: Codable {
    let page: Int
    let readingLogEntries: [ReadingLogEntry]
}

// MARK: - ReadingLogEntry
struct ReadingLogEntry: Codable {
    let work: Work
    let loggedEdition: String?
    let loggedDate: String
}

// MARK: - Work
struct Work: Codable {
    let title: String?
    let key: String
    let authorKeys, authorNames: [String]
    let firstPublishYear: Int?
    let lendingEditionS: String?
    let editionKey: [String]?
    let coverID: Int?
    let coverEditionKey: String?
}

