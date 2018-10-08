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
        sv.alwaysBounceVertical = true
        sv.backgroundColor = .clear
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    let backgroundImageView: UIImageView = {
        let image = UIImage(named: "Bitmap")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        signUpView.nameTextField.delegate = self
        signUpView.emailTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        signUpView.confirmPasswordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Remove observers
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return darkMode ? .default : .lightContent
    }
    
    func setupView() {
        
        activeField = UITextField()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        let signUpView = SignUpView(frame: self.view.frame)
        self.signUpView = signUpView
        
        self.signUpView.submitAction = submitPressed
        self.signUpView.cancelAction = cancelPressed
        
        view.addGestureRecognizer(tap)
        
        view.addSubview(backgroundImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(signUpView)
        
        backgroundImageView.setAnchor(top: view.topAnchor, topPad: 0, bottom: view.bottomAnchor, bottomPad: 0, left: view.leftAnchor, leftPad: 0, right: view.rightAnchor, rightPad: 0, height: 0, width: 0)
        
        scrollView.setAnchor(top: view.topAnchor, topPad: 0, bottom: view.bottomAnchor, bottomPad: 0, left: view.leftAnchor, leftPad: 0, right: view.rightAnchor, rightPad: 0, height: 0, width: 0)
        
        signUpView.setAnchor(top: scrollView.topAnchor, topPad: 0, bottom: scrollView.bottomAnchor, bottomPad: 0, left: scrollView.leftAnchor, leftPad: 0, right: scrollView.rightAnchor, rightPad: 0, height: 0, width: 0)

        signUpView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        signUpView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyBoardInfo = notification.userInfo else { return }
        if let keyboardSize = (keyBoardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            let keyboardHeight = keyboardSize.height + 10
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            scrollView.contentInset = contentInsets
            var viewRect = view.frame
            viewRect.size.height -= keyboardHeight
            guard let activeField = activeField else { return }
            if (!viewRect.contains(activeField.frame.origin)) {
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y - keyboardHeight)
                scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
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

extension SignUpController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        activeField = nil
        return true
    }
}
