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

            NetworkingManager.instance.getCategoryCollection(for: .horror) { result in
                switch result {
                case .success(let categoryCollection):
                    if let firstBook = categoryCollection.first?.works.first {

                        print("Title: \(firstBook.title ?? "No title")")

                        //формируем ссылку для получения обложки
                        if let coverID = firstBook.cover_id {
                            let coverURL = URL(string: "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg")!

                            NetworkingManager.instance.loadImage(from: coverURL) { image in
                                DispatchQueue.main.async {
                                    //тут нужно присваивать вьюшкам соответствующую картинку по ссылке
//                                    imageView.image = image
                                    print(coverURL)
                                }
                            }
                        } else {
                            print("No cover information available")
                        }
                    } else {
                        print("No books in the collection")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    
    private func setupConstraints() {
        homeView.snp.makeConstraints { make in
              make.edges.equalToSuperview()
          }
    }
}
