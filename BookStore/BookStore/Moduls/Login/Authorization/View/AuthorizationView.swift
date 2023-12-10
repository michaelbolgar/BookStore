//
//  AuthorizationView.swift
//  BookStore
//
//  Created by Anna Zaitsava on 10.12.23.
//

import UIKit
//MARK: - Protocol
@objc protocol AuthorizationViewDelegate: AnyObject {    
    @objc optional func didTapLogButton(email: String!, password: String!)
    @objc optional func didTapCreateAccountButton()
    @objc optional func didTapForgotPasswordButton()
    
    @objc optional func didTapRegButton(email: String!, password: String!, name: String!)
    @objc optional func didTapHaveAccountButton()
}

class AuthorizationView: UIView {
    
    //MARK: - Elements
    weak var delegate: AuthorizationViewDelegate?
    
    private lazy var bgImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "authorization_bg")
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var bg: UIView  = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .authBg
        return view
    }()
    
    private lazy var iconImage: UIImageView =  {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconforauth")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var logButton: UIButton = {
        let button = UIButton(cornerRadius: 5, title: "Sing Up",background: UIColor.elements.cgColor,titleColor: .background, fontSize: 14)
        button.backgroundColor = .elements
        return button
    }()
    
    private lazy var welcomeLabel = UILabel.makeLabel(text:"Get started", font: .openSansBold(ofSize: 24), textColor: .elements)
    
    private lazy var bottomLabel = UILabel.makeLabel(text:"By creating an account", font: .openSansRegular(ofSize: 14), textColor: .elements)
    
    private lazy var nameTextField = UITextField(placeholder: "Name")
    private lazy var emailTextField = UITextField(placeholder: "Email")
    private lazy var passwordTextField = UITextField(placeholder: "Password", isSecure: true)
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(.elements, for: .normal)
        button.titleLabel?.font = .openSansBold(ofSize: 14)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var createNewAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create new account", for: .normal)
        button.setTitleColor(.elements, for: .normal)
        button.titleLabel?.font = .openSansBold(ofSize: 14)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var haveAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Already have an account", for: .normal)
        button.setTitleColor(.elements, for: .normal)
        button.titleLabel?.font = .openSansBold(ofSize: 14)
        button.backgroundColor = .clear
        return button
    }()
    
    
    //MARK: - Private Methods
    func setupForAuthorization() {
        setupAuthActions()
        setupAuthUI()
    }
    
    func setupForRegistration() {
        setupRegActions()
        setupRegUI()
    }
    
    private func setupAuthActions() {
        logButton.addTarget(self, action: #selector(logButtonTappedForAuth), for: .touchUpInside)
        createNewAccountButton.addTarget(self, action: #selector(createNewAccountButtonTapped), for: .touchUpInside)
        haveAccountButton.addTarget(self, action: #selector(haveAccountButtonTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
    }
    
    private func setupRegActions() {
        logButton.addTarget(self, action: #selector(logButtonTappedForReg), for: .touchUpInside)
        createNewAccountButton.addTarget(self, action: #selector(createNewAccountButtonTapped), for: .touchUpInside)
        haveAccountButton.addTarget(self, action: #selector(haveAccountButtonTapped), for: .touchUpInside)
    }
    
    private func setupAuthUI() {
        
        addSubviewsTamicOff(bgImage , bg)
        bg.addSubviewsTamicOff(iconImage, welcomeLabel,bottomLabel,emailTextField,passwordTextField,forgotPasswordButton,createNewAccountButton,logButton)
        let offset: CGFloat = 20
        logButton.setTitle("Sing In", for: .normal)
        welcomeLabel.text = "Welcome back!"
        bottomLabel.text = "We missed you!"
        
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: topAnchor),
            bgImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
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
            
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            emailTextField.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -offset),
            emailTextField.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: offset),
            emailTextField.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 30),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -offset),
            passwordTextField.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: offset),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
            
            forgotPasswordButton.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -offset),
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            
            logButton.heightAnchor.constraint(equalToConstant: 56),
            logButton.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -offset),
            logButton.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: offset),
            logButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            
            createNewAccountButton.centerXAnchor.constraint(equalTo: bg.centerXAnchor),
            createNewAccountButton.topAnchor.constraint(equalTo: logButton.bottomAnchor, constant: 18),
            createNewAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -offset)
        ])
    }
    
    private func setupRegUI() {
        addSubviewsTamicOff(bgImage , bg)
        bg.addSubviewsTamicOff(iconImage, welcomeLabel,bottomLabel,nameTextField,emailTextField,passwordTextField,haveAccountButton,logButton)
        let offset: CGFloat = 20
        logButton.setTitle("Sing Up", for: .normal)
        
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: topAnchor),
            bgImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
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
            haveAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -offset)
        ])
    }
    
    //MARK: - Objc Methods
    @objc private func logButtonTappedForAuth() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        delegate?.didTapLogButton?(email: email, password: password)
    }
    
    @objc private func logButtonTappedForReg() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            return
        }
        delegate?.didTapRegButton?(email: email, password: password, name: name)
    }
    
    @objc private func createNewAccountButtonTapped() {
        delegate?.didTapCreateAccountButton?()
    }
    
    @objc private func haveAccountButtonTapped() {
        delegate?.didTapHaveAccountButton?()
    }
    
    @objc private func forgotPasswordButtonTapped() {
        delegate?.didTapForgotPasswordButton?()
    }
    
}

