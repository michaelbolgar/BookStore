//
//  SearchResultVC.swift
//  BookStore
//
//  Created by Anna Zaitsava on 5.12.23.
//

import UIKit

class SearchResultVC: UIViewController {
    
    enum SortingMethod {
        case none
        case byNewest
        case byOldest
    }
    
    
    //    public struct BookObject: Decodable {
    //
    //        public let start: Int?
    //        public let numFound: Int?
    //        public let docs: [Doc]
    //    }
    //
    //    enum CodingKeys: String, CodingKey {
    //
    //        case title_suggest = "title_suggest"
    //        case subtitle = "subtitle"
    //        case author_name = "author_name"
    //        case first_publish_year = "first_publish_year"
    //        case cover_i = "cover_i"
    //        case publisher = "publisher"
    //        case author_alternative_name = "author_alternative_name"
    //        case numFound = "num_found"
    //    }
    
    // MARK: Properties
    
    //массив для получения запроса с сервера
    var booksArray = [Doc]()
    var currentSortingMethod: SortingMethod = .none
    var books = [CategoryCollection.Work]()
    var url = [URL]()
    
    //MARK: UI Elements
    
    //когда будешь делать не хард, не забудь выставить этим лейблам цвет текста .label или другой подходящий (см. UIColor extension)
    var searchRequest = "Love"
    var numberOfBooks = 0
    var baseSearchPlaceholder =  "Search title/author/ISBN no"
    
    private lazy var numberOfResultsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = ""
        label.font = .openSansBold(ofSize: 20)
        label.textColor = .elements
        return label
        
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
//    private lazy var rightButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
//        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
//        button.tintColor = .customBlack
//        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
//        return button
//    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search title/author/ISBN no"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .label
        searchBar.barTintColor = .clear
        searchBar.layer.cornerRadius = 5
        searchBar.clipsToBounds = true
        searchBar.showsCancelButton = false
        
        // Customizing the text field
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.textColor = .customBlack
            searchTextField.font = .openSansRegular(ofSize: 14)
            searchTextField.backgroundColor = .clear
            searchTextField.borderStyle = .none
            searchTextField.leftView?.tintColor = .customBlack
            searchTextField.leftViewMode = .always
        }
        return searchBar
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customLightGray
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.layer.cornerRadius = 5
        button.menu = sortMenu
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    private lazy var sortMenu: UIMenu = {
        let filterByNewest = UIAction(title: "Sort by Newest") { _ in
            self.sortByNewest()
        }
        let filterByOldest = UIAction(title: "Sort by Oldest") { _ in
            self.sortByOldest()
        }
        let menu = UIMenu(title: "Sort by", options: .displayInline, children: [filterByNewest, filterByOldest])
        return menu
    }()
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        performSearchRequest()
        setupUI()
        
    }
    
    // MARK: Private Methods
    private func performSearchRequest() {
        NetworkingManager.instance.searchBooks(keyword: searchRequest) {
            print("hello")
        } searchCompletion: { object in
            self.booksArray = object.docs
            self.sorting()
            print(self.booksArray)
            DispatchQueue.main.async {
                self.numberOfBooks = self.booksArray.count
                self.updateNumberOfResultsLabel(withCount: self.numberOfBooks)
                self.collectionView.reloadData()
            }
        }
    }
        
    private func updateNumberOfResultsLabel(withCount count: Int) {
        numberOfResultsLabel.text = "\(count) Search Results"
    }
    
    private func sorting() {
        switch currentSortingMethod {
        case .byNewest:
            booksArray.sort { ($0.first_publish_year ?? Int.min) > ($1.first_publish_year ?? Int.min) }
            print ("по убыванию")
        case .byOldest:
            booksArray.sort { ($0.first_publish_year ?? Int.max) < ($1.first_publish_year ?? Int.max) }
            print ("по возрастанию")
        case .none:
            break
        }
        collectionView.reloadData()
    }
    
    private func sortByNewest() {
        currentSortingMethod = .byNewest
    print (currentSortingMethod)
        sorting()
    }
    
    private func sortByOldest() {
        currentSortingMethod = .byOldest
        sorting()
        print (currentSortingMethod)
    }
    
    private func setupUI() {
        view.addSubviewsTamicOff(filterButton, searchBar, numberOfResultsLabel,collectionView)
        
        let offset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            filterButton.heightAnchor.constraint(equalToConstant: 56),
            filterButton.widthAnchor.constraint(equalToConstant: 52),
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            searchBar.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 56),
            
            numberOfResultsLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: offset),
            numberOfResultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            numberOfResultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            
            collectionView.topAnchor.constraint(equalTo: numberOfResultsLabel.bottomAnchor, constant: offset),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //            rightButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -17),
            //            rightButton.heightAnchor.constraint(equalToConstant: 24),
            //            rightButton.widthAnchor.constraint(equalToConstant: 24),
            //            rightButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor)
            
        ])
    }
}


//MARK: Extensions

extension SearchResultVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        
        guard indexPath.item < booksArray.count else { return cell }
        cell.configure(with:  booksArray[indexPath.item])
        
        return cell
    }
}

extension SearchResultVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 18) / 2
        let cellHeight: CGFloat = 213
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}

extension SearchResultVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            searchRequest = text
            performSearchRequest()
            searchBar.resignFirstResponder()
        } else {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let vc = CategoriesVC()
        navigationController?.pushViewController(vc, animated: true)
        print("Cancel button clicked")
    }
    
}


