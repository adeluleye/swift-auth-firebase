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
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alwaysBounceVertical = true
        sv.backgroundColor = .clear
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return darkMode ? .default : .lightContent
    }
    
    func setupView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        let signUpView = SignUpView(frame: self.view.frame)
        self.signUpView = signUpView
        
        self.signUpView.submitAction = submitPressed
        self.signUpView.cancelAction = cancelPressed
        
        view.addGestureRecognizer(tap)
        
        view.addSubview(scrollView)
        scrollView.addSubview(signUpView)

        scrollView.setAnchor(top: view.topAnchor, topPad: 0, bottom: view.bottomAnchor, bottomPad: 0, left: view.leftAnchor, leftPad: 0, right: view.rightAnchor, rightPad: 0, height: 0, width: 0)

        signUpView.setAnchor(top: scrollView.topAnchor, topPad: 0, bottom: scrollView.bottomAnchor, bottomPad: 0, left: scrollView.leftAnchor, leftPad: 0, right: scrollView.rightAnchor, rightPad: 0, height: 0, width: 0)

        signUpView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        signUpView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
                print(err?.localizedDescription ?? "Error occured")
            } else {
                self?.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
}
