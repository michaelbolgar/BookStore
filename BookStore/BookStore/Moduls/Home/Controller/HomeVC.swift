import UIKit
import SnapKit

final class HomeVC: UIViewController {

    var array = [Doc]()
    var weeklyArray = [Doc]()
    
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
//            NetworkingManager.instance.searchBooks(keyword: "Lord of the Ring") {
//                print("hello")
//            } searchCompletion: { object in
//                self.array = object.docs
//                print(self.array)
//            }

//            NetworkingManager.instance.getWeeklyTrendingBooks {
//                print("hello")
//            } searchCompletion: { object in
//                self.weeklyArray = object.docs
//                print(self.weeklyArray)
//            }

            NetworkingManager.instance.getWeeklyTrendingBooks { result in
                switch result {
                case .success(let weeklyTrendingBooks):
                    print(weeklyTrendingBooks)
                case .failure(let error):
                    print("Ошибка при получении недельной подборки: \(error)")
                }
            }

        }
    
    private func setupConstraints() {
        homeView.snp.makeConstraints { make in
              make.edges.equalToSuperview()
          }
        
    }
}
