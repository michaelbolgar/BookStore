//
//  PagesViewController.swift
//  BookStore
//
//  Created by Alexander Altman on 05.12.2023.
//

import UIKit
import Lottie
import SnapKit

final class PagesViewController: UIView {
    
    
    //MARK: - UI Elements
    let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        return view
    }()
    
    let blurBackgroundView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var transparentView: UIView = {
        let element = UIView()
        element.backgroundColor = .darkGray.withAlphaComponent(0.7)
        element.layer.borderWidth = 5
        element.layer.borderColor = UIColor.darkGray.cgColor
        element.layer.cornerRadius = 30
        return element
    }()
    
    lazy var animationView: LottieAnimationView = {
        let element = LottieAnimationView()
        element.backgroundColor = .darkGray.withAlphaComponent(0.5)
        element.layer.borderWidth = 5
        element.layer.borderColor = UIColor.darkGray.cgColor
        element.animation = LottieAnimation.named("Animation - 1")
        element.loopMode = .loop
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        return element
    }()
    
    private lazy var pageLabel = UILabel(withTextSize: 30)
    private lazy var pageSubLabel = UILabel(withTextSize: 24)
    
    lazy var nextButton = UIButton(
        cornerRadius: 10,
        title: "Next",
        background: UIColor.white.cgColor,
        titleColor: .black,
        fontSize: 17
    )
    
    lazy var skipButton = UIButton(
        cornerRadius: 20,
        title: "Skip",
        background: UIColor.clear.cgColor,
        titleColor: .white,
        fontSize: 17
    )
    
    lazy var continueButton = UIButton(
        cornerRadius: 5,
        title: "Get Started",
        background: UIColor.black.cgColor,
        titleColor: .white,
        fontSize: 17
    )
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewsTamicOff(
            transparentView,
            blurBackgroundView,
            animationView
        )
        
        transparentView.addSubviewsTamicOff(
            blurView,
            pageLabel,
            pageSubLabel,
            continueButton,
            skipButton,
            nextButton
        )
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
        animationView.layer.masksToBounds = true
        blurBackgroundView.layer.cornerRadius = animationView.bounds.height / 2
        blurBackgroundView.layer.masksToBounds = true
        
        animationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(bounds.height / 3)
            make.width.equalTo(bounds.height / 3)
            make.top.equalTo(snp.top).offset(100)
        }
        
        transparentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(bounds.height / 2.3)
        }
        
        blurView.snp.makeConstraints { make in
            make.edges.equalTo(transparentView)
        }
        
        blurBackgroundView.snp.makeConstraints { make in
            make.edges.equalTo(animationView)
        }
        
        pageLabel.snp.makeConstraints { make in
            make.top.equalTo(transparentView.snp.top).offset(5)
            make.leading.equalTo(transparentView.snp.leading).offset(24)
            make.trailing.equalTo(transparentView.snp.trailing).offset(-24)
            make.height.equalTo(bounds.height / 7)
        }
        
        pageSubLabel.snp.makeConstraints { make in
            make.top.equalTo(pageLabel.snp.bottom)
            make.leading.equalTo(transparentView.snp.leading).offset(24)
            make.trailing.equalTo(transparentView.snp.trailing).offset(-24)
            make.height.equalTo(bounds.height / 8)
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(pageSubLabel.snp.bottom).offset(5)
            make.leading.equalTo(transparentView.snp.leading).offset(30)
            make.width.equalTo(bounds.width * 0.3)
            make.height.equalTo(bounds.width * 0.12)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(pageSubLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(bounds.width * 0.7)
            make.height.equalTo(bounds.width * 0.12)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(pageSubLabel.snp.bottom).offset(5)
            make.trailing.equalTo(transparentView.snp.trailing).offset(-30)
            make.width.equalTo(bounds.width * 0.3)
            make.height.equalTo(bounds.width * 0.12)
        }
    }
}

//MARK: - Convenience Inits
extension UIButton {
    convenience init(cornerRadius: CGFloat, title: String, background: CGColor, titleColor: UIColor, fontSize: CGFloat) {
        self.init()
        self.layer.cornerRadius = cornerRadius
        self.layer.backgroundColor = background
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.openSansBold(ofSize: fontSize)
    }
}

extension UILabel {
    convenience init(withTextSize: CGFloat) {
        self.init()
        self.textColor = .white
        self.font = UIFont.openSansBold(ofSize: withTextSize)
        self.textAlignment = .center
        self.numberOfLines = 0
    }
}
