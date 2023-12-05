//
//  LikesCell.swift
//  BookStore
//
//  Created by Кристина Максимова on 05.12.2023.
//

import UIKit
import SnapKit

final class LikesCell: UICollectionViewCell {

    //MARK: - create UIElements
    private lazy var genre: UILabel = {
        let label = UILabel.makeMultiLineLabel(text: "Genre", font: UIFont(name: "OpenSans-Regular", size: 12), textColor: .white, numberOfLines: 2)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel.makeMultiLineLabel(text: "Name Book", font: UIFont(name: "OpenSans-Bold", size: 18), textColor: .white, numberOfLines: 2)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var author: UILabel = {
        let label = UILabel.makeMultiLineLabel(text: "Author", font: UIFont(name: "OpenSans-Regular", size: 14), textColor: .white, numberOfLines: 2)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "moon.dust"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    //MARK: - configureUICollectionViewCell
    private func setLayout() {
        contentView.addSubview(genre)
        contentView.addSubview(name)
        contentView.addSubview(author)
        contentView.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(142)
            make.width.equalTo(96)
        }
        
        genre.snp.makeConstraints { make in
            make.top.equalTo(14)
            make.height.equalTo(14)
            make.width.equalTo(160)
            make.leading.equalTo(image.snp.trailing).offset(11)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(genre.snp.bottom).offset(4)
            make.leading.equalTo(image.snp.trailing).offset(11)
            make.height.equalTo(38)
            make.width.equalTo(142)
        }
        
        author.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(4)
            make.leading.equalTo(image.snp.trailing).offset(11)
            make.height.equalTo(14)
            make.width.equalTo(62)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
