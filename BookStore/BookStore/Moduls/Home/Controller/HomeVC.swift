import UIKit
import SnapKit

final class HomeVC: UIViewController {
    
    private let homeView = HomeView()

    var array = [Doc]()
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
        NetworkingManager.instance.searchBooks(keyword: "Lord of the Ring") {
            print("hello")
        } searchCompletion: { object in
            self.array = object.docs
            print(self.array)
        }

    }
    
    private func setupConstraints() {
        homeView.snp.makeConstraints { make in
              make.edges.equalToSuperview()
          }
        
    }
    
}

