//
//  SignUpView.swift
//  FirebaseAuthNSB
//
//  Created by ADELU ABIDEEN ADELEYE on 10/4/18.
//  Copyright © 2018 Spantom Technologies Ltd. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(backgroundImageView)
        
        backgroundImageView.setAnchor(top: self.topAnchor, topPad: 0, bottom: self.bottomAnchor, bottomPad: 0, left: self.leftAnchor, leftPad: 0, right: self.rightAnchor, rightPad: 0, height: 0, width: 0)
    }
    
    let backgroundImageView: UIImageView = {
        let image = UIImage(named: "Bitmap")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
}
