//
//  CategoriesCell.swift
//  BookStore
//
//  Created by Кристина Максимова on 06.12.2023.
//

<<<<<<< HEAD

import UIKit
import SnapKit

final class CategoriesCell: UICollectionViewCell {
    
    //MARK: - Create UIElements
    private lazy var genre = UILabel.makeMultiLineLabel(font: UIFont(name: "OpenSans-Regular", size: 20), textColor: .white, numberOfLines: 2)
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "moon.dust"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        genre.text = "Categories" // удалю после создания модельки
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PrivateMethods
    private func setLayout() {
        contentView.addSubview(image)
        contentView.addSubview(genre)
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(150)
        }
        
        genre.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
            make.height.equalTo(32)
            make.width.equalTo(87)
        }
    }
}
=======
import Foundation
>>>>>>> cf5fc0e60d5ebc34ab0693f5f1289ebf4f399058
=======
import Foundation
>>>>>>> cf5fc0e60d5ebc34ab0693f5f1289ebf4f399058
