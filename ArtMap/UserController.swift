//
//  UserController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 20/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import Parse

class UserController: NSObject{
    
    var userList : [User] = [User]()

    func createList(object: PFObject) -> User{
        
        let tmp = User(object: object)
        userList.append(tmp)
        
        return tmp
        
    }
}
