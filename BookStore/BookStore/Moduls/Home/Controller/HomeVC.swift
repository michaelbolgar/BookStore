import UIKit
import SnapKit

final class HomeVC: UIViewController {

    //этот массив можно использовать для наполнения полученными данными
//    var array = [TrendingBooks]()
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

      }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            //search example
//            NetworkingManager.instance.searchBooks(keyword: "Harry Potter") {
//                print("hello")
//            } searchCompletion: { object in
//                self.array = object.docs
//                print(self.array)
//            }

            //getting weekly top example
//            NetworkingManager.instance.getTrendingBooks(for: .weekly) { result in
//                switch result {
//                case .success(let trendingBooks):
//                    print(trendingBooks)
//                    print(trendingBooks[0])
//                    print(trendingBooks[0].author_name ?? "No author")
//                case .failure(let error):
//                    print("Ошибка при получении недельной подборки: \(error)")
//                }
//            }

            //get category collection example
            NetworkingManager.instance.getCategoryCollection (for: .love) { result in
                switch result {
                case .success(let subjectResponse):
//                    print(subjectResponse)
//                    print(subjectResponse[0].works)

                    for book in subjectResponse[0].works {
                        if let title = book.title {
                            print(title)
                        }
                    }

                case .failure(let error):
                    print("Ошибка при получении категорий: \(error)")
                }
            }

        }
    
    private func setupConstraints() {
        homeView.snp.makeConstraints { make in
              make.edges.equalToSuperview()
          }
        
    }
}
