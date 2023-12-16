import UIKit
import SnapKit

final class HomeVC: UIViewController {
    
    private let homeView = HomeView()
  
        override func viewDidLoad() {
            
           
            super.viewDidLoad()
            view.backgroundColor = .background
            
            view.addSubview(homeView)
            
            setupConstraints()
            
            homeView.setViews()
            homeView.setupConstraints()
            homeView.setDelegates()

        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            //getting weekly top example
            NetworkingManager.instance.getTrendingBooks(for: .weekly) { result in
                switch result {
                case .success(let trendingBooks):
//                    print(trendingBooks)
//                    print(trendingBooks[0])
//                    print(trendingBooks[0].author_name ?? "No author")

                    if let firstBook = trendingBooks.first {
                        print("Title: \(firstBook.0.title ?? "No title")")
//                        print("Author: \(firstBook.0.author_name?.joined(separator: ", ") ?? "No author")")
                        print("Cover URL: \(firstBook.1)")

                        //в данной функции результат выводится кортежем, поэтому firstBook.0 -- это инфа по книга, а firstBook.1 -- это ссылка
                    }
                case .failure(let error):
                    print("Ошибка при получении недельной подборки: \(error)")
                }
            }


            //пример получения данных книги по ключу
            NetworkingManager.instance.getBookDetails(for: "/works/OL82586W") { result in
                switch result {
                case .success(let bookDetails):
                    print(bookDetails.description?.value ?? "No description")
                case .failure(let error):
                    print ("Ошибка при получении деталей книги: \(error)")
                }
            }
        }
    

        private func setupConstraints() {
            homeView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
        }
    }


    
