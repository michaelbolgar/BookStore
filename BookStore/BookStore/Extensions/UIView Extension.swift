//
//  UIView Extension.swift
//  BookStore
//
//  Created by Anna Zaitsava on 5.12.23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }
}
