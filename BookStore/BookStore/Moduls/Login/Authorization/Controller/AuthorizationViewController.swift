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
    private lazy var authorizationController = AuthorizationView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authorizationController.delegate = self
    }
    
    //MARK: - Methods
    private func setupUI() {
        view.addSubviewsTamicOff(authorizationController)
        
        NSLayoutConstraint.activate([
            authorizationController.topAnchor.constraint(equalTo: view.topAnchor),
            authorizationController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authorizationController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authorizationController.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        authorizationController.setupForAuthorization()
    }
}

//MARK: - UITextField Delegate
extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK: - AuthorizationView Methods Delegate
extension AuthorizationViewController: AuthorizationViewDelegate {
    
    func didTapLogButton(email: String!, password: String!) {
        guard let email = email, let password = password else {
            print("Invalid email or password")
            return
        }        
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if let error = error {
                let alertController = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                print("User logged in successfully!")
                let homeVC = MainTabBarController()
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true)
            }
        }
        
    }
    
    func didTapForgotPasswordButton() {
        let alertController = UIAlertController(title: "Forgot your password?", message: "Too bad. We didn't make a password reset functionality yet.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK🥲", style: .default) { (action) in
            print("OK Button Pressed")
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}


