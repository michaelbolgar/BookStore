//
//  BookDetailsView.swift
//  BookStore
//
//  Created by Alexander Altman on 10.12.2023.
//

import UIKit

//MARK: - Convenience Inits
extension UILabel {
    convenience init(text1: String, text2: String) {
        self.init()
        let regularFont = UIFont.openSansRegular(ofSize: 14)
        let boldFont = UIFont.openSansBold(ofSize: 14)
        let attributedText = NSMutableAttributedString(
            string: text1,
            attributes: [.font: regularFont ?? UIFont.systemFont(ofSize: 14),
                         .foregroundColor: UIColor.labelColors])
        let categoryText = NSAttributedString(
            string: text2,
            attributes: [.font: boldFont ?? UIFont.boldSystemFont(ofSize: 14),
                         .foregroundColor: UIColor.labelColors])
        attributedText.append(categoryText)
        self.attributedText = attributedText
        self.numberOfLines = 0
    }
}
