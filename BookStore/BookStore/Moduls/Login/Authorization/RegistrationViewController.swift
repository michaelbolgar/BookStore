//
//  RegistrationViewController.swift
//  BookStore
//
//  Created by Anna Zaitsava on 9.12.23.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    //MARK: - Elements
    private lazy var bgImage: UIView = {
        let view = UIView()
        let image = UIImage()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var bg: UIView  = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var iconImage: UIImageView =  {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appIconM")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    private lazy var logButton = UIButton(cornerRadius: 5, title: "Sing Up",background: UIColor.black.cgColor,titleColor: .white, fontSize: 14)
    
    private lazy var welcomeLabel = UILabel.makeLabel(text:"Get started", font: .openSansBold(ofSize: 24), textColor: .customBlack)
    
    private lazy var bottomLabel = UILabel.makeLabel(text:"By creating an account", font: .openSansRegular(ofSize: 14), textColor: .customBlack)
    
    private lazy var nameTextField = UITextField(placeholder: "Name")
    private lazy var emailTextField = UITextField(placeholder: "Email")
    private lazy var passwordTextField = UITextField(placeholder: "Password")

    private lazy var haveAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create new account", for: .normal)
        button.setTitleColor(.customBlack, for: .normal)
        button.titleLabel?.font = .openSansBold(ofSize: 14)
        button.backgroundColor = .clear
        return button
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        view.addSubviewsTamicOff(bgImage , bg)
        bg.addSubviewsTamicOff(iconImage, welcomeLabel,bottomLabel,nameTextField,emailTextField,passwordTextField,haveAccountButton,logButton)
        let offset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bg.bottomAnchor.constraint(equalTo: bgImage.bottomAnchor),
            bg.trailingAnchor.constraint(equalTo: bgImage.trailingAnchor),
            bg.leadingAnchor.constraint(equalTo: bgImage.leadingAnchor),
            bg.heightAnchor.constraint(greaterThanOrEqualToConstant: 564),
            
            iconImage.centerXAnchor.constraint(equalTo: bg.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: bg.topAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 136),
            iconImage.widthAnchor.constraint(equalToConstant: 136),
            
            welcomeLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 30),
            
            bottomLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor),
            bottomLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 56),
            nameTextField.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -offset),
            nameTextField.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: offset),
            nameTextField.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 30),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            emailTextField.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -offset),
            emailTextField.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: offset),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -offset),
            passwordTextField.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: offset),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
            
            logButton.heightAnchor.constraint(equalToConstant: 56),
            logButton.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -offset),
            logButton.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: offset),
            logButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            
            haveAccountButton.centerXAnchor.constraint(equalTo: bg.centerXAnchor),
            haveAccountButton.topAnchor.constraint(equalTo: logButton.bottomAnchor, constant: 18),
            haveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -offset)
            
        ])
        
    }
}

// MARK: - UITextField Padding
