import UIKit
import SnapKit

final class HomeVC: UIViewController {

    //этот массив можно использовать для наполнения полученными данными
    var array = [TrendingBooks]()
    
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
                    print(trendingBooks)
                    print(trendingBooks[0])
                    print(trendingBooks[0].author_name ?? "No author")
//                    print(self.fetchImage(cover_i: trendingBooks[0].cover_i ?? 0, forImage: UIImageView?))
                    let url = "https://covers.openlibrary.org/b/id/" + "\(trendingBooks[10].cover_i)" + "-M.jpg"
                    print(url)
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
    
    func fetchImage(cover_i: Int, forImage: UIImageView) {
        let url = "https://covers.openlibrary.org/b/id/" + "\(trendingBooks[10].cover_i)" + "-M.jpg"
        if let imageURL = URL(string: url){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        forImage.image = image
                    }
                }
            }
        }
    }
}
