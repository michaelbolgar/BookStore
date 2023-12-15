//
//  CategoriesCell.swift
//  BookStore
//
//  Created by Кристина Максимова on 06.12.2023.
//

import UIKit
import SnapKit

final class CategoriesCell: UICollectionViewCell {
    
    //MARK: - Create UIElements
    var genre = UILabel.makeMultiLineLabel(font: UIFont.openSansRegular(ofSize: 20),
                                                        textColor: .label,
                                                        numberOfLines: 2)
    
    var image: UIImageView = {
        let image = UIImageView(image: UIImage())
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PrivateMethods
    private func setLayout() {
        contentView.backgroundColor = .elements
        contentView.addSubview(image)
        contentView.addSubview(genre)
        
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(150)
        }
        
        genre.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.width.equalTo(87)
        }
    }
}
