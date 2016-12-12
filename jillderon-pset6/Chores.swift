//
//  Chores.swift
//  jillderon-pset6
//
//  Created by Jill de Ron on 07-12-16.
//  Copyright © 2016 Jill de Ron. All rights reserved.
//

import Foundation
import Firebase

struct Chores {
    
    let key: String
    let name: String
    let ref: FIRDatabaseReference?
    var completed: Bool
    
    init(name: String, completed: Bool, key: String = "") {
        self.key = key
        self.name = name
        self.completed = completed
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "completed": completed
        ]
    }
    
}
