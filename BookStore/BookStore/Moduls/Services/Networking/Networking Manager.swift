import UIKit

public class NetworkingManager {

    static let instance = NetworkingManager()

    var searchCompletion: ((BookObject) -> Void)?
    var timer: Timer?

    var urlEndpoints = [("&mode=everything", false),
                       ("&sort=editions&mode=everything", false),
                       ("&sort=old&mode=everything", false),
                       ("&sort=new&mode=everything", false),
                       ("https://openlibrary.org/search.json?title=", true),
                       ("https://openlibrary.org/search.json?author=", true),
                        ("https://openlibrary.org/trending/weekly.json", false)]

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

//    public func getWeeklyTrendingBooks(completion: @escaping (BookObject) -> Void) {
//        guard let url = URL(string: "https://openlibrary.org/trending/weekly.json") else { return }
//
//        importJson(url: url.absoluteString, completion: completion)
//    }

    func getWeeklyTrendingBooks(completion: @escaping (Result<WeeklyTrendingBooks, Error>) -> Void) {
            let weeklyTrendingURL = "https://openlibrary.org/trending/weekly.json"

            guard let url = URL(string: weeklyTrendingURL) else {
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
                    let weeklyTrendingBooks = try JSONDecoder().decode(WeeklyTrendingBooks.self, from: data)
                    completion(.success(weeklyTrendingBooks))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
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

struct WeeklyTrendingBooks: Codable {
    let query: String
    let works: [Book]

    struct Book: Codable {
        let key: String?
        let title: String?
        let edition_count: Int?
        let first_publish_year: Int?
        let has_fulltext: Bool?
        let public_scan_b: Bool?
        let ia: [String]?
        let ia_collection_s: String?
        let cover_edition_key: String?
        let cover_i: Int?
        let language: [String]?
        let author_key: [String]?
        let author_name: [String]?
        let availability: Availability?

        struct Availability: Codable {
            let status: String?
            let available_to_browse: Bool?
            let available_to_borrow: Bool?
            let available_to_waitlist: Bool?
            let is_printdisabled: Bool?
            let is_readable: Bool?
            let is_lendable: Bool?
            let is_previewable: Bool?
            let identifier: String?
            let isbn: String?
            let oclc: String?
            let openlibrary_work: String?
            let openlibrary_edition: String?
            let last_loan_date: String?
            let num_waitlist: String?
            let last_waitlist_date: String?
            let is_restricted: Bool?
            let is_browseable: Bool?
            let src: String?
        }
    }
}
