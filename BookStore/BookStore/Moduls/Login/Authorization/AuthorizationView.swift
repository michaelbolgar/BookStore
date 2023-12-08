//
//  AuthorizationView.swift
//  BookStore
//
//  Created by Anna Zaitsava on 8.12.23.
//

import UIKit

class AuthorizationView: UIViewController {
    
    private lazy var bgImage = UIImage(named: "home_unselected")
    
    private lazy var bg: UIView  = {
     let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var iconImage = UIImage(named: "home_unselected")
    
    private lazy var logButton = UIButton(cornerRadius: 5, title: "Sing In",background: UIColor.black.cgColor,titleColor: .white, fontSize: 14)
    
    private lazy var welcomeLabel = UILabel.makeLabel(font: .openSansBold(ofSize: 24), textColor: .customBlack)
    
    private lazy var bottomLabel = UILabel.makeLabel(font: .openSansRegular(ofSize: 14), textColor: .customBlack)
    
    private lazy var nameTextField: UITextField =  {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.font = .openSansRegular(ofSize: 14)
        textField.backgroundColor = .customLightGray
        return textField
    }()
    
    private lazy var passwordTextField: UITextField =  {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = .openSansRegular(ofSize: 14)
        textField.backgroundColor = .customLightGray
        return textField
    }()
    
    private lazy var forgotPasswordLabel = UILabel.makeLabel(font: .openSansBold(ofSize: 14), textColor: .customBlack)
    
    private lazy var newAccountLabel = UILabel.makeLabel(font: .openSansBold(ofSize: 14), textColor: .customBlack)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        
        view.addSubviews(welcomeLabel,bottomLabel,nameTextField,passwordTextField,forgotPasswordLabel,newAccountLabel,logButton)
        NSLayoutConstraint.activate([
        
            
        ])
        
    }
}
