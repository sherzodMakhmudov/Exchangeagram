//
//  LoginViewController.swift
//  Aincrad
//
//  Created by Sherzod Makhmudov on 12/23/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD


//Tutorial 10 shows how to connect ios to a server
class LoginViewController: UIViewController{

    var topView: UIView = {
          let view = UIView()
          view.translatesAutoresizingMaskIntoConstraints = false
          return view
    }()
    var logoImageView:UIImageView = {
        let image = UIImage(named: "aincrad")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var emailTextfield: UITextField = {
        let textfield = UITextField()
        let attributedString = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textfield.attributedPlaceholder = NSAttributedString(attributedString: attributedString)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .white
        textfield.textColor = .black
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 5
        return textfield
    }()
    
    var passwordTextfield: UITextField = {
        let textfield = UITextField()
        let attributedString = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textfield.attributedPlaceholder = NSAttributedString(attributedString: attributedString)
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .white
        textfield.borderStyle = .none
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 5
        textfield.textColor = .black
        return textfield
    }()
    
    var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
           super.viewDidLoad()
        view.backgroundColor = .init(white: 0.95, alpha: 1)
        view.addSubview(topView)
        topView.addSubview(logoImageView)
        view.addSubview(emailTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(loginButton)
            
        setupLayout()
       }
    
    func setupLayout(){
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        logoImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 20).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1/2).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1/2).isActive = true
        
        emailTextfield.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30).isActive = true
        emailTextfield.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
        emailTextfield.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.2).isActive = true
        emailTextfield.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 8).isActive = true
        passwordTextfield.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
        passwordTextfield.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.2).isActive = true
        passwordTextfield.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 10).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.2).isActive = true
        loginButton.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }

    @objc func goToRegister() {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true)
    }

    @objc func handleLogin(){
        guard let email = emailTextfield.text else {return}
        guard let password = passwordTextfield.text else {return}

        let url = "http://localhost:1337/api/v1/entrance/login"
        let params = ["emailAddress": email, "password": password]
        Alamofire.request(url, method: .put, parameters: params, encoding: URLEncoding()).responseData { (dataResponse) in
            print(dataResponse)
            self.dismiss(animated: true)
        }

    }
}
