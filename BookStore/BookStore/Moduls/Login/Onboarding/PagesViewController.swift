//
//  PagesViewController.swift
//  BookStore
//
//  Created by Alexander Altman on 05.12.2023.
//

import UIKit
import Lottie

final class PagesViewController: UIView {
    
    
    let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let blurBackgroundView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Elements
    private lazy var transparentView: UIView = {
        let element = UIView()
        element.backgroundColor = .darkGray.withAlphaComponent(0.7)
        element.layer.borderWidth = 5
        element.layer.borderColor = UIColor.darkGray.cgColor
        element.layer.cornerRadius = 30
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var animationView: LottieAnimationView = {
        let element = LottieAnimationView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .darkGray.withAlphaComponent(0.5)
        element.layer.borderWidth = 5
        element.layer.borderColor = UIColor.darkGray.cgColor
        element.animation = LottieAnimation.named("Animation - 1")
        element.loopMode = .loop
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        return element
    }()
    
    private lazy var pageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.openSansBold(ofSize: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pageSubLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.openSansBold(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
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
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor.black.cgColor
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = UIFont.openSansBold(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(transparentView)
        addSubview(blurBackgroundView)
        addSubview(animationView)
        transparentView.addSubview(blurView)
        transparentView.addSubview(pageLabel)
        transparentView.addSubview(pageSubLabel)
        transparentView.addSubview(continueButton)
        transparentView.addSubview(skipButton)
        transparentView.addSubview(nextButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
        animationView.play()
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
        animationView.transform = transform
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
        animationView.layer.cornerRadius = animationView.bounds.height / 2
        blurBackgroundView.layer.cornerRadius = animationView.bounds.height / 2
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.heightAnchor.constraint(equalToConstant: bounds.height / 3),
            animationView.widthAnchor.constraint(equalToConstant: bounds.height / 3),
            animationView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            transparentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            transparentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            transparentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            transparentView.heightAnchor.constraint(equalToConstant: bounds.height / 2.3),
            
            blurView.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor),
            blurView.topAnchor.constraint(equalTo: transparentView.topAnchor),
            
            blurBackgroundView.leadingAnchor.constraint(equalTo: animationView.leadingAnchor),
            blurBackgroundView.trailingAnchor.constraint(equalTo: animationView.trailingAnchor),
            blurBackgroundView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor),
            blurBackgroundView.topAnchor.constraint(equalTo: animationView.topAnchor),
            
            pageLabel.topAnchor.constraint(equalTo: transparentView.topAnchor, constant: 5),
            pageLabel.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor, constant: 24),
            pageLabel.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor, constant: -24),
            pageLabel.heightAnchor.constraint(equalToConstant: bounds.height / 7),
            
            pageSubLabel.topAnchor.constraint(equalTo: pageLabel.bottomAnchor),
            pageSubLabel.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor, constant: 24),
            pageSubLabel.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor, constant: -24),
            pageSubLabel.heightAnchor.constraint(equalToConstant: bounds.height / 8),
            
            skipButton.topAnchor.constraint(equalTo: pageSubLabel.bottomAnchor, constant: 5),
            skipButton.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor, constant: 30),
            skipButton.widthAnchor.constraint(equalToConstant: 90),
            skipButton.heightAnchor.constraint(equalToConstant: 58),
            
            continueButton.topAnchor.constraint(equalTo: pageSubLabel.bottomAnchor, constant: 5),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: bounds.width * 0.7),
            continueButton.heightAnchor.constraint(equalToConstant: 58),
            
            nextButton.topAnchor.constraint(equalTo: pageSubLabel.bottomAnchor, constant: 5),
            nextButton.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor, constant: -30),
            nextButton.widthAnchor.constraint(equalToConstant: 90),
            nextButton.heightAnchor.constraint(equalToConstant: 58),
        ])
    }
}
