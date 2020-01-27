//
//  SignUpViewController.swift
//  Aincrad
//
//  Created by Sherzod Makhmudov on 12/26/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import LBTATools
import Alamofire

class SignUpViewController: LBTAFormController{
    
    let logoImageView = UIImageView(image: UIImage(named: "aincrad"), contentMode: .scaleAspectFit)
    let logoLabel = UILabel(text: "Aincrad", font: .systemFont(ofSize: 32, weight: .heavy), textColor: .black, numberOfLines: 0)
    let nameTextField = IndentedTextField(placeholder: "Full Name", padding: 24, cornerRadius: 25)
    let emailTextField = IndentedTextField(placeholder: "Email", padding: 24, cornerRadius: 25, keyboardType: .emailAddress)
    let passwordTextField = IndentedTextField(placeholder: "Password", padding: 24, cornerRadius: 25)
    lazy var loginButton = UIButton(title: "Sign Up", titleColor: .white, font: .boldSystemFont(ofSize: 18), backgroundColor: .black, target: self, action: #selector(handleSignUp))

    let errorLabel = UILabel(text: "Your login credentials were incorrect, please try again.", font: .systemFont(ofSize: 14), textColor: .red, textAlignment: .center, numberOfLines: 0)

    lazy var goToLoginButton = UIButton(title: "Go back to Login", titleColor: .black, font: .systemFont(ofSize: 16), target: self, action: #selector(goToLogin))
    
    override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .init(white: 0.95, alpha: 1)
           
           nameTextField.backgroundColor = .white
           emailTextField.autocapitalizationType = .none
           emailTextField.backgroundColor = .white
           passwordTextField.backgroundColor = .white
           passwordTextField.isSecureTextEntry = true
           loginButton.layer.cornerRadius = 25
           navigationController?.navigationBar.isHidden = true
           errorLabel.isHidden = true
           
           let formView = UIView()
           formView.stack(
               formView.stack(formView.hstack(logoImageView.withSize(.init(width: 80, height: 80)), logoLabel.withWidth(160), spacing: 16, alignment: .center).padLeft(12).padRight(12), alignment: .center),
               UIView().withHeight(12),
               nameTextField.withHeight(50),
               emailTextField.withHeight(50),
               passwordTextField.withHeight(50),
               loginButton.withHeight(50),
               errorLabel,
               goToLoginButton,
               UIView().withHeight(80),
               spacing: 16).withMargins(.init(top: 48, left: 32, bottom: 0, right: 32))
           
           formContainerStackView.padBottom(-24)
           formContainerStackView.addArrangedSubview(formView)
       }
    
    @objc func handleSignUp(){
        guard let url = URL(string: "http://localhost:1337/api/v1/entrance/signup") else {return}
        guard let name = nameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        let params = ["fullName":name, "emailAddress": email, "password": password]
        Alamofire.request(url, method: .post, parameters: params).validate(statusCode: 200..<300).responseData { (dataResponse) in
            if let error = dataResponse.error{
                print("Registration error:", error)
                return
            }
            print(dataResponse.response)
        }
      
        
    }
    
    @objc func goToLogin(){
        dismiss(animated: true, completion: nil)
    }
}
