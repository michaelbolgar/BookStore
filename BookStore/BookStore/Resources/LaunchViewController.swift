//
//  LaunchViewController.swift
//  BookStore
//
//  Created by Alexander Altman on 12.12.2023.
//

import UIKit
import Lottie

final class LaunchViewController: UIViewController {
    
    //MARK: - Dependencies
    let animations = ["Animation - 1", "Animation - 2", "Animation - 3"]
    
    //MARK: - UI Elements
    private lazy var bgImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "backSlide04")
        element.alpha = 0.8
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private lazy var upperLabel: UILabel = {
        let element = UILabel()
        element.text = "BookStore"
        element.font = UIFont.openSansBold(ofSize: 60)
        element.textColor = .systemBlue
        element.adjustsFontSizeToFitWidth = true
        element.shadowOffset = CGSize(width: 0, height: -22)
        element.shadowColor = .systemRed
        element.textAlignment = .center
        return element
    }()
    
    private lazy var lowerLabel: UILabel = {
        let element = UILabel()
        element.text = "by SM X Team 2"
        element.font = UIFont.openSansSemiBoldItalic(ofSize: 30)
        element.textAlignment = .center
        return element
    }()
    
    lazy var animationView: LottieAnimationView = {
        let element = LottieAnimationView()
        element.animation = LottieAnimation.named(animations.randomElement()!)
        element.loopMode = .loop
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setConstraints()
        animationView.play()
    }

    //MARK: - Private Methods
    private func setupViews() {
        view.addSubviewsTamicOff(bgImage, upperLabel, lowerLabel, animationView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            upperLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            upperLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            upperLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            
            lowerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -26),
            lowerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            lowerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.7),
            animationView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7)
        ])
    }
}
