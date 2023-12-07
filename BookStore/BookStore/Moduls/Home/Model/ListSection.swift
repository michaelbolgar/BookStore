//
//  ListSection.swift
//  BookStore
//
//  Created by Сазонов Станислав on 05.12.2023.
//

import Foundation

enum ListSection {
    case topBooks([ListItem])
    case recentBooks([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .topBooks(let items),
                .recentBooks(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
            
        case .topBooks(_):
            return "Top Books"
        case .recentBooks(_):
            return "Recent Books"
        }
    }
}
