//
//  LikesCell.swift
//  BookStore
//
//  Created by Кристина Максимова on 05.12.2023.
//

import UIKit
import SnapKit

final class LikesCell: UICollectionViewCell {

    //MARK: - Create UIElements
    var genre = UILabel.makeMultiLineLabelWithLeftTextAlignment(text: "Genre",
                                                                             font: UIFont.openSansRegular(ofSize: 12),
                                                                             textColor: .label,
                                                                             numberOfLines: 2)
    
    var name = UILabel.makeMultiLineLabelWithLeftTextAlignment(text: "Name Book",
                                                                            font: UIFont.openSansBold(ofSize: 18),
                                                                            textColor: .label,
                                                                            numberOfLines: 2)
    
    var author = UILabel.makeMultiLineLabelWithLeftTextAlignment(text: "Author",
                                                                              font: UIFont.openSansRegular(ofSize: 12),
                                                                              textColor: .label,
                                                                              numberOfLines: 2)
    
    var image: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "hourglass"))
        image.backgroundColor = .background
        image.tintColor = .authDark
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        contentView.addSubview(genre)
        contentView.addSubview(name)
        contentView.addSubview(author)
        contentView.addSubview(image)
        contentView.addSubview(closeButton)
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(142)
            make.width.equalTo(96)
        }
        
        genre.snp.makeConstraints { make in
            make.top.equalTo(14)
            make.width.equalTo(160)
            make.leading.equalTo(image.snp.trailing).offset(11)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(genre.snp.bottom).offset(4)
            make.leading.equalTo(image.snp.trailing).offset(11)
            make.width.equalTo(160)
        }
        
        author.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(4)
            make.leading.equalTo(image.snp.trailing).offset(11)
            make.width.equalTo(160)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(14)
            make.trailing.equalTo(snp.trailing).offset(-9)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
}

// MARK: - Extensions

private extension UILabel {
    static func makeMultiLineLabelWithLeftTextAlignment(text: String = "", font: UIFont?, textColor: UIColor, numberOfLines: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = .left
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
