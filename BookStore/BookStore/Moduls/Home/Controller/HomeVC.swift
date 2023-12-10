import UIKit
import SnapKit

final class HomeVC: UIViewController {

    var array = [Doc]()
    
    private let homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        view.addSubview(homeView)

        setupConstraints()

        homeView.setViews()
        homeView.setupConstraints()
        homeView.setDelegates()

        fetchRecentBooks()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        NetworkingManager.instance.searchBooks(keyword: "Lord of the Ring") {
//            print("hello")
//        } searchCompletion: { object in
//            self.array = object.docs
//            print(self.array)
//        }
//
//    }
    
    private func setupConstraints() {
        homeView.snp.makeConstraints { make in
              make.edges.equalToSuperview()
          }
        
    }

//    func fetchRecentBooks() {
//        let apiUrl = "https://openlibrary.org/recentchanges.json?limit=10"
//
//        guard let url = URL(string: apiUrl) else {
//            print("Invalid API URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//
//
//            guard let data = data, error == nil else {
//            print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
//            return
//        }
//
//            do {
//                // Декодируем JSON-ответ в массив словарей
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
//                    // Преобразуем каждый элемент массива в структуру Book
//                    let books = json.compactMap { bookData -> ListItem? in
//                        guard let title = bookData["title"] as? String,
//                              let author = bookData["author"] as? String else {
//                                return nil
//                        }
//                        return ListItem(title: title, subTitle: author)
//                    }
//
//                    // Обновляем UI на основе полученных данных
//                    DispatchQueue.main.async {
//                        self.updateCollectionView(with: books)
//                    }
//                }
//            } catch {
//                print("Error decoding JSON: \(error.localizedDescription)")
//            }
//        }.resume()
//    }

//    func updateCollectionView(with items: [ListItem]) {
//
//    }
    
}

