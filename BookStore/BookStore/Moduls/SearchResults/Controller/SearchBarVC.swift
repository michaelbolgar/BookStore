//
//  SearchBarVC.swift
//  BookStore
//
//  Created by Anna Zaitsava on 13.12.23.
//
//
//import UIKit
//
//protocol SearchBarDelegate: AnyObject {
//    func filterButtonTapped()
//}
//
//class SearchBar: UIView {
//
//    weak var delegate: SearchBarDelegate?
//    var searchRequest = ""
//    var basePlaceholder = "Search title/author/ISBN no"
//
//    private lazy var searchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.delegate = self
//        searchBar.searchBarStyle = .minimal
//        configureSearchBar(searchBar)
//        return searchBar
//    }()
//
//    private lazy var filterButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .customLightGray
//        button.setImage(UIImage(named: "filter"), for: .normal)
//        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    init() {
//        super.init(frame: .zero)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//    }
//
//    private func setupUI() {
//        addSubviewsTamicOff(searchBar,filterButton)
//
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        filterButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            searchBar.topAnchor.constraint(equalTo: topAnchor),
//            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
//            searchBar.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8),
//            searchBar.heightAnchor.constraint(equalToConstant: 56),
//
//            filterButton.topAnchor.constraint(equalTo: topAnchor),
//            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
//            filterButton.widthAnchor.constraint(equalToConstant: 52),
//            filterButton.heightAnchor.constraint(equalToConstant: 56)
//        ])
//    }
//
//    @objc private func filterButtonTapped() {
//        delegate?.filterButtonTapped()
//    }
//
//    func setPlaceholder(_ placeholder: String) {
//        searchBar.placeholder = placeholder
//    }
//
//
//
//    private func configureSearchBar(_ searchBar: UISearchBar) {
//        searchBar.placeholder = basePlaceholder
//        searchBar.backgroundColor = .customLightGray
//        searchBar.barTintColor = .clear
//        searchBar.layer.cornerRadius = 5
//        searchBar.clipsToBounds = true
//
//        // Customizing the text field
//        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
//            searchTextField.textColor = .customBlack
//            searchTextField.font = .openSansRegular(ofSize: 14)
//            searchTextField.backgroundColor = .clear
//            searchTextField.borderStyle = .none
//            searchTextField.leftView?.tintColor = .customBlack
//            searchTextField.leftViewMode = .always
//        }
//    }
//}
//
//extension SearchBar: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if let text = searchBar.text, !text.isEmpty {
//            let vc = SearchResultVC()
//            vc.searchRequest = text
//            navigationController?.pushViewController(vc, animated: true)
//        } else {
//            searchBar.resignFirstResponder()
//        }
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = nil
//        searchBar.placeholder = "Search title/author/ISBN no"
//        searchBar.resignFirstResponder()
//        navigationController?.popViewController(animated: true)
//    }
//}


//import UIKit
//
//class SearchableViewController: UIViewController, UISearchBarDelegate {
//    var searchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.searchBarStyle = .minimal
//        searchBar.backgroundColor = .customLightGray
//        searchBar.barTintColor = .clear
//        searchBar.layer.cornerRadius = 5
//        searchBar.clipsToBounds = true
//        return searchBar
//    }()
//
//    var filterButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .customLightGray
//        button.setImage(UIImage(named: "filter"), for: .normal)
//        button.layer.cornerRadius = 5
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupSearchBar()
//
//    }
//
//    func setupSearchBar() {
//        searchBar.delegate = self
//addSubviewsTamicOff(searchBar,filterButton)
//
//searchBar.translatesAutoresizingMaskIntoConstraints = false
//filterButton.translatesAutoresizingMaskIntoConstraints = false
//
//NSLayoutConstraint.activate([
//    searchBar.topAnchor.constraint(equalTo: topAnchor),
//    searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
//    searchBar.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8),
//    searchBar.heightAnchor.constraint(equalToConstant: 56),
//
//    filterButton.topAnchor.constraint(equalTo: topAnchor),
//    filterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
//    filterButton.widthAnchor.constraint(equalToConstant: 52),
//    filterButton.heightAnchor.constraint(equalToConstant: 56)
//])
//}
//    }
//
//    // Дополнительный код вашего контроллера
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if let text = searchBar.text, !text.isEmpty {
//let vc = SearchResultVC()
//vc.searchRequest = text
//        } else {
//            searchBar.resignFirstResponder()
//        }
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = nil
//        searchBar.placeholder = "Search title/author/ISBN no"
//        searchBar.resignFirstResponder()
//        navigationController?.popViewController(animated: true)
//    }
//
//
//}
