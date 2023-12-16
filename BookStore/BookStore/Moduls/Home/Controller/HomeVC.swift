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

//            NetworkingManager.instance.getCategoryCollection(for: .fiction) { result in
//                switch result {
//                case .success(let categoryCollection):
//                    print(categoryCollection)
//                    if let firstBook = categoryCollection.first?.works.first {
//
//                        print("Title: \(firstBook.title ?? "No title")")
////                        print("Author: \(firstBook.authors.name ?? "No author")")
//
//                        //формируем ссылку для получения обложки
//                        if let coverID = firstBook.cover_id {
//                            let coverURL = URL(string: "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg")!
//
//                            NetworkingManager.instance.loadImage(from: coverURL) { image in
//                                DispatchQueue.main.async {
//                                    //тут нужно присваивать вьюшкам соответствующую картинку по ссылке
////                                    imageView.image = image
//                                    print(coverURL)
//                                }
//                            }
//                        } else {
//                            print("No cover information available")
//                        }
//                    } else {
//                        print("No books in the collection")
//                    }
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }
        }
    
    
        private func setupConstraints() {
            homeView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
        }
    }


    
