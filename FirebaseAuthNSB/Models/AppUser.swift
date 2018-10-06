//
//  AppUser.swift
//  FirebaseAuthNSB
//
//  Created by ADELU ABIDEEN ADELEYE on 10/6/18.
//  Copyright © 2018 Spantom Technologies Ltd. All rights reserved.
//

import Foundation
import Firebase

struct AppUser {
    var name: String?
    var uid: String?
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else { return }
        guard let name = value["name"] as? String else { return }
        self.name = name
    }
}
