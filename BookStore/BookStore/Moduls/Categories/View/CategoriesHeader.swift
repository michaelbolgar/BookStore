//
//  CategoriesHeader.swift
//  BookStore
//
//  Created by Кристина Максимова on 06.12.2023.
//

<<<<<<< HEAD
<<<<<<< HEAD
import UIKit
import SnapKit

final class CategoriesHeader: UICollectionReusableView {
    
    //MARK: - UI Elements
    lazy var headerLabel = UILabel.makeLabel(text: "Categories", font: UIFont.openSansRegular(ofSize: 20), textColor: .black)
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Propetries
    private func setupViews() {
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
=======
import Foundation
>>>>>>> cf5fc0e60d5ebc34ab0693f5f1289ebf4f399058
=======
import Foundation
>>>>>>> cf5fc0e60d5ebc34ab0693f5f1289ebf4f399058
