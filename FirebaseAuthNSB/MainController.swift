//
//  MainController.swift
//  FirebaseAuthNSB
//
//  Created by ADELU ABIDEEN ADELEYE on 10/6/18.
//  Copyright © 2018 Spantom Technologies Ltd. All rights reserved.
//

import UIKit
import Firebase

class MainController: UIViewController {
    
    var appUser: AppUser? {
        didSet {
            print("value set")
            guard let userName = appUser?.name else { return }
            navigationItem.title = userName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Your Name"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOut))
        
        fetchUserInfo()
    }
    
    @objc func logOut() {
        FirebaseAPI.shared.logOut { [weak self] (err) in
            if err != nil {
                // alert
                print(err?.localizedDescription ?? "Error occured")
            } else {
                self?.showLoginController()
            }
        }
    }
    
    func showLoginController() {
        let loginController =  UINavigationController(rootViewController: LoginController())
        present(loginController, animated: true, completion: nil)
    }
    
    func fetchUserInfo() {
        FirebaseAPI.shared.fetch { [weak self] (user) in
            if user != nil {
                self?.appUser = user
            }
        }
    }
}
