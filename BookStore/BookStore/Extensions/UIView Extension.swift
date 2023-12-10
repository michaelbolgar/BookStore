//
//  UIView + ext.swift
//  BookStore
//
//  Created by Alexander Altman on 06.12.2023.
//

import UIKit

extension UIView {
    
    func addSubviewsTamicOff(_ views: UIView...) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
