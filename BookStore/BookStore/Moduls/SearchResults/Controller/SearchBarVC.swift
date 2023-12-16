//
//  SearchBarVC.swift
//  BookStore
//
//  Created by Anna Zaitsava on 13.12.23.
//

import UIKit

protocol SearchBarVCDelegate: AnyObject {
    func searchButtonClicked(withRequest text: String, sortingMethod: SearchResultVC.SortingMethod)
    func searchCancelButtonClicked()
}

class SearchBarVC: UIView {
    
    weak var delegate: SearchBarVCDelegate?
    
    private var choosenSortingMethod: SearchResultVC.SortingMethod = .none
    
    lazy var searchBar: UISearchBar = {
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
            searchTextField.textColor = .elements
            searchTextField.font = .openSansRegular(ofSize: 14)
            searchTextField.backgroundColor = .clear
            searchTextField.borderStyle = .none
            searchTextField.leftView?.tintColor = .elements
            searchTextField.leftViewMode = .always
        }
        return searchBar
    }()
    
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.layer.cornerRadius = 5
        button.menu = sortMenu
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    private lazy var sortMenu: UIMenu = {
        let filterByNewest = UIAction(title: "Sort by Newest", handler: { [weak self] _ in
            self?.choosenSortingMethod = .byNewest
        })
        
        let filterByOldest = UIAction(title: "Sort by Oldest", handler: { [weak self] _ in
            self?.choosenSortingMethod = .byOldest
        })
        
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
            vc.currentSortingMethod = choosenSortingMethod
            self.delegate?.searchButtonClicked(withRequest: text, sortingMethod: choosenSortingMethod)
            searchBar.resignFirstResponder()
        } else {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.resignFirstResponder()
        self.delegate?.searchCancelButtonClicked()
    }
    
}

