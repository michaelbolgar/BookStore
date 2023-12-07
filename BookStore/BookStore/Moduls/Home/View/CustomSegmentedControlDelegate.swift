//
//  CustomSegmentedControlDelegate.swift
//  BookStore
//
//  Created by Сазонов Станислав on 07.12.2023.
//

import Foundation

protocol CustomSegmentedControlDelegate: AnyObject {
    
    func buttonPressed(buttonTitlesIndex: Int, title: String?)
}
