//
//  SignUpController.swift
//  FirebaseAuthNSB
//
//  Created by ADELU ABIDEEN ADELEYE on 10/4/18.
//  Copyright © 2018 Spantom Technologies Ltd. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    var signUpView: SignUpView!
    
    var darkMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return darkMode ? .default : .lightContent
    }
    
    func setupView() {
        let signUpView = SignUpView(frame: self.view.frame)
        self.signUpView = signUpView
        
        self.signUpView.submitAction = submitPressed
        self.signUpView.cancelAction = cancelPressed
        
        self.view.addSubview(signUpView)
    }
    
    func submitPressed() {
        // unwrap using guard statement because the values are optional
        guard let email = signUpView.emailTextField.text else { return }
        guard let password = signUpView.passwordTextField.text else { return }
        guard let name = signUpView.nameTextField.text else { return }
        
        // implement user creation
        FirebaseAPI.shared.signUp(name: name, email: email, password: password) { [weak self] (err) in
            if err != nil {
                // error alert
                print(err?.localizedDescription)
            } else {
                self?.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
}
