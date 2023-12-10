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
    private lazy var genre = UILabel.makeMultiLineLabel(font: UIFont.openSansRegular(ofSize: 20),
                                                        textColor: .label,
                                                        numberOfLines: 2)
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "AppIcon"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        genre.text = "Categories" // удалю после создания модельки
        setImageShadow()
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
    
    private func setImageShadow() {
        let topImageGradient = CAGradientLayer()
        topImageGradient.frame = CGRect(x: 0, 
                                        y: 0,
                                        width: image.bounds.width,
                                        height: image.bounds.height/10)
        topImageGradient.colors = [UIColor.black.withAlphaComponent(0.8).cgColor,
                                   UIColor.black.withAlphaComponent(0.1).cgColor]
        image.layer.insertSublayer(topImageGradient, at: 0)
    }
}
