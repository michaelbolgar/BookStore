//
//  AuthorizationView.swift
//  BookStore
//
//  Created by Anna Zaitsava on 8.12.23.
//

import UIKit
import FirebaseAuth

class AuthorizationViewController: UIViewController {
    
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
    
    private lazy var emailTextField = UITextField(placeholder: "Email")
    private lazy var passwordTextField = UITextField(placeholder: "Password")
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(.customBlack, for: .normal)
        button.titleLabel?.font = .openSansBold(ofSize: 14)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var createNewAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create new account", for: .normal)
        button.setTitleColor(.customBlack, for: .normal)
        button.titleLabel?.font = .openSansBold(ofSize: 14)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(createNewAccountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    @objc func createNewAccountButtonTapped() {
        let vc = RegistrationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func forgotPasswordButtonTapped() {
        let alertController = UIAlertController(title: "Forgot your password?", message: "Too bad. We didn't make a password reset functionality yet.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK🥲", style: .default) { (action) in
            print("OK Button Pressed")
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func logButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Invalid email or password")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {user, error in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
            } else {
                if let user = user {
                    print("User logged in successfully!")
                    let homeVC = MainTabBarController()
                    homeVC.modalPresentationStyle = .fullScreen
                    self.present(homeVC, animated: true)
                }
            }
        }
    }
            
            private func setupUI() {
                logButton.addTarget(self, action: #selector(logButtonTapped), for: .touchUpInside)
                
                view.addSubviewsTamicOff(bgImage , bg)
                bg.addSubviewsTamicOff(iconImage, welcomeLabel,bottomLabel,emailTextField,passwordTextField,forgotPasswordButton,createNewAccountButton,logButton)
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
                    createNewAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -offset)
                    
                ])
                
            }
        }
        
