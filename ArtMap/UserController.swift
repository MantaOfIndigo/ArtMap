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
    
    private var userList : [User] = [User]()

    func createList(object: PFObject) -> User{
        
        let tmp = User(object: object)
        userList.append(tmp)
        return tmp
        
    }
    
    func count()->Int{
        return userList.count
    }
    
    func getList() -> [User]{
        return self.userList
    }
    
    func checkEmail(email: String) -> Bool{
        for user in self.userList{
            if user.getEmail() == email{
                return false
            }
        }
        return true
    }
    func checkUsername(username: String) -> Bool{
        for user in self.userList{
            if user.getUsername() == username{
                return false
            }
        }
        return true
    }
    
    func retrieveByUsername(username: String) -> User?{
        
        
        for user in self.userList{
            
            if user.getUsername() == username{
                return user
            }else if user.getUsername().containsString(username){
                if user.compareUsernames(username){
                    return user
                }
                
            }
        }
        return nil
    }
    
    func retrieveByMail(email: String) -> User?{
        for user in self.userList{
            if user.getEmail() == email{
                return user
            }
        }
        return nil
    }
    
    func uploadInfoUser(username : String, parameter: String){
        
        let upUser = self.retrieveByUsername(username)
        
        if parameter == "REPORT"{
            upUser?.addReport()
        }
        if parameter == "UPPHOTO"{
            upUser?.addPublishedPhoto()
        }
        if parameter == "CHECKIN"{
            upUser?.addCheckins()
        }
        if parameter == "COUNTER"{
            upUser?.addCheckCounter()
        }
        
        //let intrct = Interactor()
        
        //intrct.uploadUserParameter(upUser.getUsername, parameter: parameter)
    }
    
     
}
