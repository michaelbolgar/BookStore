//
//  AuthorizationView.swift
//  BookStore
//
//  Created by Anna Zaitsava on 8.12.23.
//

import UIKit

class AuthorizationView: UIViewController {
    
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
    
    private lazy var logButton = UIButton(cornerRadius: 5, title: "Sing In",background: UIColor.black.cgColor,titleColor: .white, fontSize: 14)
    
    private lazy var welcomeLabel = UILabel.makeLabel(text:"Welcome back!", font: .openSansBold(ofSize: 24), textColor: .customBlack)
    
    private lazy var bottomLabel = UILabel.makeLabel(text:"We missed you!", font: .openSansRegular(ofSize: 14), textColor: .customBlack)
    
    
    
    private lazy var nameTextField: UITextField =  {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.font = .openSansRegular(ofSize: 14)
        textField.backgroundColor = .customLightGray
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(12)
        textField.setRightPaddingPoints(12)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField =  {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = .openSansRegular(ofSize: 14)
        textField.backgroundColor = .customLightGray
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(12)
        textField.setRightPaddingPoints(12)
        return textField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(.customBlack, for: .normal)
        button.titleLabel?.font = .openSansBold(ofSize: 14)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var createNewAccountButton: UIButton = {
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
        bg.addSubviewsTamicOff(iconImage, welcomeLabel,bottomLabel,nameTextField,passwordTextField,forgotPasswordButton,createNewAccountButton,logButton)
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
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -offset),
            passwordTextField.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: offset),
            passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25),
            
            forgotPasswordButton.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -offset),
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            
            logButton.heightAnchor.constraint(equalToConstant: 56),
            logButton.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -offset),
            logButton.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: offset),
            logButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            
            createNewAccountButton.centerXAnchor.constraint(equalTo: bg.centerXAnchor),
            createNewAccountButton.topAnchor.constraint(equalTo: logButton.bottomAnchor, constant: 18),
            createNewAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -offset)
            
        ])
        
    }
}

// MARK: - UITextField Padding
extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
