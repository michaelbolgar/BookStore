//
//  UIView + ext.swift
//  BookStore
//
//  Created by Alexander Altman on 06.12.2023.
//

import UIKit

extension UIView {

    static var identifier: String {
        return String(describing: self)
    }
    
    func addSubviewsTamicOff(_ views: UIView...) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
