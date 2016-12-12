//
//  User.swift
//  jillderon-pset6
//
//  Created by Jill de Ron on 07-12-16.
//  Copyright © 2016 Jill de Ron. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

struct User {
    
    let uid: String
    let email: String
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
