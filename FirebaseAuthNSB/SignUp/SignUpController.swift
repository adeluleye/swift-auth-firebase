//
//  SignUpController.swift
//  FirebaseAuthNSB
//
//  Created by ADELU ABIDEEN ADELEYE on 10/4/18.
//  Copyright © 2018 Spantom Technologies Ltd. All rights reserved.
//

import UIKit

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
        self.view.addSubview(signUpView)
    }
}
