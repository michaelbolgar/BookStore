//
//  TopBooksViewCell.swift
//  BookStore
//
//  Created by Сазонов Станислав on 05.12.2023.
//

import UIKit
import SnapKit

final class TopBooksViewCell: UICollectionViewCell {
    
    //MARK: UI Elements
    
    private let topBooksImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let footerView: UIView = {
        let element = UIView()
        
        element.backgroundColor = .black
        element.layer.cornerRadius = 8
        element.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return element
    }()
    
    private let bookGenreLabel = UILabel.makeLabel(
        text: "Top Books",
        font: .openSansRegular(ofSize: 11),
        textColor: .white
    )
    private var bookTitleLabel = UILabel.makeLabel(
        text: "Top Books",
        font: .openSansRegular(ofSize: 15),
        textColor: .white
    )
    private let bookAuthorLabel = UILabel.makeLabel(
        text: "Top Books",
        font: .openSansRegular(ofSize: 11),
        textColor: .white
    )
    
    private let textStackView = UIStackView(spacing: 10, axis: .vertical, alignment: .leading)
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Views
    
    private func setupView() {
        backgroundColor = .lightGray
        addSubview(topBooksImageView)
        addSubview(footerView)
        footerView.addSubview(textStackView)
        textStackView.addArrangedSubview(bookGenreLabel)
        textStackView.addArrangedSubview(bookTitleLabel)
        textStackView.addArrangedSubview(bookAuthorLabel)
        
        layer.cornerRadius = 8
    }
    
    // MARK: - Cell Configure
    
    func configureCell(book: TrendingBooks.Book) {
        //        bookGenreLabel.text = book
        bookTitleLabel.text = book.title
        bookAuthorLabel.text = book.author_name?.first
        if let coverId = book.cover_i, let imageUrl = URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg") {
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: imageUrl) { (data, response, error) in
                if let e = error {
                    print("Error downloading image: \(e)")
                } else {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self.topBooksImageView.image = image
                        }
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                }
            }
            downloadPicTask.resume()
        }
    }
    
    
    
    // MARK: - Setup Constraints
    
    private func setConstraints() {
        
        topBooksImageView.snp.makeConstraints { make in
            make.width.equalTo(91)
            make.height.equalTo(141)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        footerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(100)
            
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            
        }
        
        textStackView.snp.makeConstraints { make in
            make.edges.equalTo(footerView.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        }
        
        bookGenreLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
        
        bookAuthorLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
        layoutIfNeeded()
    }
    
    
    
}
