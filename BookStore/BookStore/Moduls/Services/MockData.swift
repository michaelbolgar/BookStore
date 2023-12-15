//
//  MocData.swift
//  BookStore
//
//  Created by Сазонов Станислав on 05.12.2023.
//

import Foundation

struct MockData {
    
    static let shared = MockData()
    
    private let topBooks: ListSection = {
        .topBooks([
        ])
    }()
    
    private let recentBooks: ListSection = {
        .recentBooks([.init(image: "home_unselected", title: "", subTitle: ""),
                      .init(image: "home_unselected", title: "", subTitle: ""),
                      .init(image: "home_unselected", title: "", subTitle: ""),
                      .init(image: "home_unselected", title: "", subTitle: ""),
        ])
    }()
    
    var pageData: [ListSection] {
        [topBooks, recentBooks]
    }
    
 
}
