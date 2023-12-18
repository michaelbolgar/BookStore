//
//  RegistrationViewController.swift
//  BookStore
//
//  Created by Anna Zaitsava on 9.12.23.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    //MARK: - Elements
    private let nameUserDefaultsKey = "UserName"    
    private lazy var registrationController = AuthorizationView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registrationController.delegate = self
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        view.addSubviewsTamicOff(registrationController)
    
        NSLayoutConstraint.activate([
            registrationController.topAnchor.constraint(equalTo: view.topAnchor),
            registrationController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registrationController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registrationController.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        registrationController.setupForRegistration()
    }
    
    private func errorAlert() {
        let alertController = UIAlertController(title: "Registration Error", message: "Name are required", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func saveUserDataToUserDefaults(name: String) {
        UserDefaults.standard.set(name, forKey: nameUserDefaultsKey)
    }
}

//MARK: - UITextField Delegate
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
//MARK: - AuthorizationView Methods Delegate
extension RegistrationViewController: AuthorizationViewDelegate {
    
    func didTapRegButton(email: String!, password: String!, name: String!) {
        guard let email =  email, let password = password, let name = name, !name.isEmpty else {
            errorAlert()
                return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let alertController = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                print("User registered successfully!")
                self.saveUserDataToUserDefaults(name: name)
                let vc = MainTabBarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }
    
    func didTapHaveAccountButton() {
        let vc = AuthorizationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

