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
    
    // save state
    let defaults = UserDefaults.standard
    var ref: DatabaseReference!
    
    var appUser: AppUser? {
        didSet {
            print("value set")
            guard let userName = appUser?.name else { return }
            navigationItem.title = userName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Your Name"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOut))
        
        fetchUserInfo()
    }
    
    @objc func logOut() {
        do {
            try Auth.auth().signOut()
            defaults.set(false, forKey: "UserIsLoggedIn")
            
            let loginController =  UINavigationController(rootViewController: LoginController())
            present(loginController, animated: true, completion: nil)
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func fetchUserInfo() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        ref.child("users").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            guard let data = snapshot.value as? NSDictionary else { return }
            guard let username = data["name"] as? String else { return }
            self.appUser = AppUser(name: username, uid: userId)
        }
    }
}
