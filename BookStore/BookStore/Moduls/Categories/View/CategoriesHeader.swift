//
//  CategoriesHeader.swift
//  BookStore
//
//  Created by Кристина Максимова on 06.12.2023.
//

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
