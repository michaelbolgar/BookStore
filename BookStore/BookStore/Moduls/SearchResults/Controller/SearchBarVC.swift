//
//  SearchBarVC.swift
//  BookStore
//
//  Created by Anna Zaitsava on 13.12.23.
//

import UIKit

//protocol SearchBarVCDelegate: AnyObject {
//    func searchButtonClicked(withRequest text: String)
//    func cancelButtonClicked()
//    func filterButtonClicked(sortMethod: SearchResultVC.SortingMethod)
//}

class SearchBarVC: UIView {

//    weak var delegate: SearchBarVCDelegate?
    

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
            let vc  = SearchResultVC()
            vc.currentSortingMethod = .byNewest
            print (vc.currentSortingMethod)
        }
        let filterByOldest = UIAction(title: "Sort by Oldest") { _ in
            let vc  = SearchResultVC()
            vc.currentSortingMethod = .byOldest
            print(vc.currentSortingMethod)
        }
        return UIMenu(title: "Sort by", options: .displayInline, children: [filterByNewest, filterByOldest])
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        addSubviewsTamicOff(searchBar,filterButton)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 56),
        
            filterButton.topAnchor.constraint(equalTo: topAnchor),
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterButton.widthAnchor.constraint(equalToConstant: 52),
            filterButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

}

// MARK: - UISearchBarDelegate
extension SearchBarVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                
        if let text = searchBar.text, !text.isEmpty {
            let vc = SearchResultVC()
            vc.searchRequest = text
            print (vc.searchRequest)
            searchBar.resignFirstResponder()
        } else {
            searchBar.resignFirstResponder()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        delegate?.cancelButtonClicked()
        print ("отработал")
    }
}

