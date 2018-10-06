//
//  ViewController.swift
//  FirebaseAuthNSB
//
//  Created by ADELU ABIDEEN ADELEYE on 10/4/18.
//  Copyright © 2018 Spantom Technologies Ltd. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    var loginView: LoginView!
    
    var darkMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return darkMode ? .default : .lightContent
    }
    
    func setupView() {
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.loginView.loginAction = loginPressed
        self.loginView.signupAction = signupPressed
        self.view.addSubview(loginView)
        loginView.setAnchor(top: view.topAnchor, topPad: 0, bottom: view.bottomAnchor, bottomPad: 0, left: view.leftAnchor, leftPad: 0, right: view.rightAnchor, rightPad: 0, height: 0, width: 0)
    }
    
    func loginPressed() {
        guard let email = loginView.emailTextField.text else { return }
        guard let password = loginView.passwordTextField.text else { return }
        
        FirebaseAPI.shared.logIn(email: email, password: password) { [weak self] (err) in
            if err != nil {
                // show error alert
            } else {
                self?.showMainController()
            }
        }
    }
    
    func showMainController() {
        let mainController = UINavigationController(rootViewController: MainController())
        self.present(mainController, animated: true, completion: nil)
    }
    
    func signupPressed() {
        let signUpController = SignUpController()
        present(signUpController, animated: true, completion: nil)
    }


}

