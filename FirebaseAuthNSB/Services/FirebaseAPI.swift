//
//  FirebaseAPI.swift
//  FirebaseAuthNSB
//
//  Created by ADELU ABIDEEN ADELEYE on 10/6/18.
//  Copyright © 2018 Spantom Technologies Ltd. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseAPI {
    
    static let shared = FirebaseAPI()
    
    private init() {
        
    }
    
    private let ref = Database.database().reference()
    
    var userID: String? {
        get {
            return Auth.auth().currentUser?.uid
        }
    }
    
    func signUp(name: String, email: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        
        let userData: [String: Any] = [
            "name": name
        ]
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let err = error {
                print(err.localizedDescription)
                completionHandler(err)
            } else {
                guard let uid = result?.user.uid else { return }
                self.ref.child("users/\(uid)").setValue(userData)
                UserDefaultsManager.shared.userIsLoggedIn = false
                print("Successfully created a user", uid)
                completionHandler(nil)
            }
        }
    }
    
    func logOut(completionHandler: (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            UserDefaultsManager.shared.userIsLoggedIn = false
            completionHandler(nil)
            print("Successfully logged out")
        } catch let error {
            print(error.localizedDescription)
            completionHandler(error)
        }
    }
    
    func logIn(email: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let err = error {
                completionHandler(err)
                print(err.localizedDescription)
            } else {
                guard let uid = user?.user.uid else { return }
                print("User: \(uid) logged in successfully")
                UserDefaultsManager.shared.userIsLoggedIn = true
                completionHandler(nil)
            }
        }
    }
    
    func fetch(completionHandler: @escaping (AppUser?) -> Void) {
        guard let userID = userID else { return }
        ref.child("users").child(userID).observeSingleEvent(of: .value) { (snapshot) in
            
            let appUser = AppUser(snapshot: snapshot)
            completionHandler(appUser)
            print("Successfully fetched user info")
        }
    }
}
