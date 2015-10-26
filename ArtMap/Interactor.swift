//
//  Interactor.swift
//  ArtMap
//
//  Created by Andrea Mantani on 20/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import Parse

class Interactor : UIViewController{
    
    func retrieveUserList(controller: UserController) -> UserController{
        let query = PFQuery(className:"_User")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) users.")
                if let objects = objects as [PFObject]? {
                    for object in objects {
                        controller.createList(object)
                    }
                }
                
            }
        }
        
        return controller
        
    }

    
    func retrieveUserRecord(user: String) -> User{
        let query = PFQuery(className:"_User")
        query.whereKey("username", equalTo: user as AnyObject)
        print("user:  ", user)
        var returnUser = User()
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil{
                returnUser = User(object: object!)
            }
        }
        
        return returnUser
    }
    
    func retriveDBMarkerImage(marker: Marker) -> UIImage{
        //UIImageWriteToSavedPhotosAlbum(retriveDBMarkerInfo(marker).getImage(), self, "image:didFinishSavingWithError:contextInfo", nil)
        
        return retriveDBMarkerInfo(marker).getImage()
    }
    
   
    func retriveDBMarkerInfo(marker: Marker) -> Marker{
        let query = PFQuery(className:"MainDB")
        query.whereKey("artId", equalTo: marker.getId() as AnyObject)
        
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            } else {
                marker.setInfoFromRecord(object!)
                
                let userImageFile = object!["image"] as! PFFile
                userImageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        if let imageData = imageData {
                            marker.setImage(UIImage(data:imageData)!)
                        }
                    }
                }
            }
        }
        
        return marker
        
    }
    
    func uploadNewUser(user: User, password : String){
        let usr = PFUser()
        usr.username = user.getUsername()
        usr.password = password
        usr["checkCounter"] = 0
        usr["checkIns"] = 0
        usr.email = user.getEmail()
        usr["phone"] =  000000000//non implementato
        usr["publishedPhotos"] = 0
        usr["reports"] = 0
        usr["votes"] = 0
        
        usr.signUpInBackgroundWithBlock{
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error{
                _ = error.userInfo["error"] as? NSString
            }
        }
    }
}

