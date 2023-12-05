//
//  PagesViewController.swift
//  BookStore
//
//  Created by Alexander Altman on 05.12.2023.
//

import UIKit

final class PagesViewController: UIView {
    
    //MARK: - Elements
    private lazy var transparentView: UIView = {
        let element = UIView()
        element.backgroundColor = .darkGray.withAlphaComponent(0.9)
        element.layer.cornerRadius = 30
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var circleImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "circleLogo")
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.openSansBold(ofSize: 34)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pageSubLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.openSansRegular(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.layer.backgroundColor = UIColor.white.cgColor
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.openSansBold(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.layer.backgroundColor = .none
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.openSansBold(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.layer.backgroundColor = UIColor.green.cgColor
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = UIFont.openSansBold(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(transparentView)
        addSubview(circleImageView)
        transparentView.addSubview(pageLabel)
        transparentView.addSubview(pageSubLabel)
        transparentView.addSubview(continueButton)
        transparentView.addSubview(skipButton)
        transparentView.addSubview(nextButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    public func setPageLabelText(text: NSAttributedString, text2: NSAttributedString) {
        pageLabel.attributedText = text
        pageSubLabel.attributedText = text2
    }
    
    public func setTransformWith(transform: CGAffineTransform) {
        pageLabel.transform = transform
        pageSubLabel.transform = transform
        circleImageView.transform = transform
    }
    
    public func hideContinueButton() {
        continueButton.isHidden = true
    }
    
    public func hideSkipNextButtons() {
        skipButton.isHidden = true
        nextButton.isHidden = true
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        circleImageView.layer.cornerRadius = circleImageView.bounds.height / 2
        
        NSLayoutConstraint.activate([
            circleImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleImageView.heightAnchor.constraint(equalToConstant: bounds.height / 4),
            circleImageView.widthAnchor.constraint(equalToConstant: bounds.height / 4),
            circleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            transparentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            transparentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            transparentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            transparentView.heightAnchor.constraint(equalToConstant: bounds.height / 2.1),
            
            pageLabel.topAnchor.constraint(equalTo: transparentView.topAnchor, constant: 24),
            pageLabel.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor, constant: 24),
            pageLabel.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor, constant: -24),
            pageLabel.heightAnchor.constraint(equalToConstant: bounds.height / 6),
            
            pageSubLabel.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 10),
            pageSubLabel.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor, constant: 24),
            pageSubLabel.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor, constant: -24),
            pageSubLabel.heightAnchor.constraint(equalToConstant: bounds.height / 7),
            
            skipButton.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor, constant: -56),
            skipButton.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor, constant: 30),
            skipButton.widthAnchor.constraint(equalToConstant: 90),
            skipButton.heightAnchor.constraint(equalToConstant: 58),
            
            continueButton.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor, constant: -56),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 260),
            continueButton.heightAnchor.constraint(equalToConstant: 58),
            
            nextButton.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor, constant: -56),
            nextButton.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor, constant: -30),
            nextButton.widthAnchor.constraint(equalToConstant: 90),
            nextButton.heightAnchor.constraint(equalToConstant: 58),
        ])
    }
}
