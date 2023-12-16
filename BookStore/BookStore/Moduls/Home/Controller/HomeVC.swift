import UIKit
import SnapKit

final class HomeVC: UIViewController {
    
    private let homeView = HomeView()

    private lazy var search =  SearchBarVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        search.delegate = self
        
        view.addSubviewsTamicOff(homeView,search)
        
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
                    print("Author: \(firstBook.0.author_name?.joined(separator: ", ") ?? "No author")")
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super .touchesBegan(touches, with: event)
    }
    

    private func setupConstraints() {
        
        let offset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            
            homeView.topAnchor.constraint(equalTo: search.bottomAnchor, constant: offset),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset),
            search.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            search.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            search.heightAnchor.constraint(equalToConstant: 56),
        ])
        //        homeView.snp.makeConstraints { make in
        //              make.edges.equalToSuperview()
        //          }
        
    }
}

// MARK: - SearchBarDelegate
extension HomeVC: SearchBarVCDelegate {
    func searchCancelButtonClicked() {
        self.search.endEditing(true)
        self.search.resignFirstResponder()
    }
    
    func searchButtonClicked(withRequest text: String, sortingMethod: SearchResultVC.SortingMethod) {
        let vc = SearchResultVC()
        vc.searchRequest = text
        vc.currentSortingMethod = sortingMethod
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
