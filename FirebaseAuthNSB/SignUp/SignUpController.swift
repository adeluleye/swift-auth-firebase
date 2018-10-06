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
    
    var defaults = UserDefaults.standard
    
    // get ref to user name in Database
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
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
        
        let userData: [String: Any] = [
            "name": name
        ]
        
        // implement user creation
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            if let err = err {
                print(err.localizedDescription)
            } else {
                // uid is optional, therefore unwrap
                guard let uid = result?.user.uid else { return }
                self.ref.child("users/\(uid)").setValue(userData)
                self.defaults.set(false, forKey: "UserIsLoggedIn")
                print("User account created successfully", uid)
                
                // dismiss the control after account signup
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
}
