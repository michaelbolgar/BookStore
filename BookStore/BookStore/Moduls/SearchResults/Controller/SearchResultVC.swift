//
//  SearchResultVC.swift
//  BookStore
//
//  Created by Anna Zaitsava on 5.12.23.
//

import UIKit

class SearchResultVC: UIViewController {

    // MARK: Properties

    //массив для получения запроса с сервера
    var array = [Doc]()

    private let books: [Book] = [

        //ата-та за форс анврап, заменил на безопасное извлечение
        Book(author: "Oscar Wilde", bookImage: UIImage(named: "bookforsearch") ?? UIImage(), label: "The Picture of Dorian Gray", genre: "Classics"),
        Book(author: "J.K. Rowling", bookImage: UIImage(named: "bookforsearch") ?? UIImage(), label: "Harry Potter and the Philosopher's Stone", genre: "Fantasy"),
        Book(author: "Maureen Johnson", bookImage: UIImage(named: "bookforsearch") ?? UIImage(), label: "Nine Liars", genre: "Young adult"),
        Book(author: "Maureen Johnson2", bookImage: UIImage(named: "bookforsearch") ?? UIImage(), label: "Nine Liars2", genre: "Young adult2"),

    ]

    //MARK: UI Elements

    //когда будешь делать не хард, не забудь выставить этим лейблам цвет текста .label или другой подходящий (см. UIColor extension)
    var searchRequest = "Something"
    var numberLabel = "4 Search results"

    private lazy var numberOfResultsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = numberLabel
        label.font = .openSansBold(ofSize: 20)
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

    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .customBlack
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc func rightButtonTapped() {
        let vc = CategoriesVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = searchRequest
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .customLightGray
        searchBar.barTintColor = .clear
        searchBar.layer.cornerRadius = 5
        searchBar.clipsToBounds = true
//        searchBar.addSubviewsTamicOff(rightButton)

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

    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()

//        search example
            NetworkingManager.instance.searchBooks(keyword: "Harry Potter") {
                print("hello")
            } searchCompletion: { object in
                self.array = object.docs
                print(self.array)
            }
    }

    // MARK: Private Methods

    private func setupUI() {
        view.addSubviewsTamicOff(searchBar, numberOfResultsLabel,collectionView)

        numberOfResultsLabel.textAlignment = .left

        NSLayoutConstraint.activate([

            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 56),

            numberOfResultsLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            numberOfResultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numberOfResultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            collectionView.topAnchor.constraint(equalTo: numberOfResultsLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

//            rightButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -16),
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
        return books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell

        // Настройка ячейки с данными
        cell.configure(with: books[indexPath.item])

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
           print("Search button clicked")
       }

       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

           print("Cancel button clicked")
       }

}
