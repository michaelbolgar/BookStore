import UIKit
import SnapKit

final class HomeVC: UIViewController {

    //этот массив можно использовать для наполнения полученными данными
//    var array = [TrendingBooks]()
    
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
        }
    
    private func setupConstraints() {
        homeView.snp.makeConstraints { make in
              make.edges.equalToSuperview()
          }
        
    }
}
