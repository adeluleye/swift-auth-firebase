//
//  LoginView.swift
//  FirebaseAuthNSB
//
//  Created by ADELU ABIDEEN ADELEYE on 10/4/18.
//  Copyright © 2018 Spantom Technologies Ltd. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(backgroundImageView)
        backgroundImageView.setAnchor(top: self.topAnchor, topPad: 0, bottom: self.bottomAnchor, bottomPad: 0, left: self.leftAnchor, leftPad: 0, right: self.rightAnchor, rightPad: 0, height: 0, width: 0)
    }
    
    let backgroundImageView: UIImageView = {
        let image = UIImage(named: "Bitmap")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.textColor = UIColor(white: 0.9, alpha: 0.8)
        textField.backgroundColor = UIColor.rgb(r: 216, g: 216, b: 216, a: 0.2)
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.autocorrectionType = .no
        // placeholder
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(white: 1, alpha: 0.7)]))
        textField.attributedPlaceholder = placeholder
        textField.setAnchor(width: 0, height: 40)
        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.textColor = UIColor(white: 0.9, alpha: 0.8)
        textField.backgroundColor = UIColor.rgb(r: 216, g: 216, b: 216, a: 0.2)
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.autocorrectionType = .no
        // placeholder
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(white: 1, alpha: 0.7)]))
        textField.attributedPlaceholder = placeholder
        textField.setAnchor(width: 0, height: 40)
        
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedString, for: .normal)
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.rgb(r: 80, g: 227, b: 194, a: 1).cgColor
        
        button.setAnchor(width: 0, height: 50)
        
        return button
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedString, for: .normal)
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.rgb(r: 255, g: 151, b: 164, a: 1).cgColor
        
        button.setAnchor(width: 0, height: 50)
        
        return button
    }()
    
}
