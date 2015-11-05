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

    func retrieveUserObject(user: String) -> PFObject{
        let query = PFQuery(className:"_User")
        query.whereKey("username", equalTo: user as AnyObject)
        var returnUser = PFObject(className: "_User")
        do{
            if let tmp : NSArray = try query.findObjects(){
                for usr in tmp{
                    returnUser = usr as! PFObject
                }
            }else{
                print("No such items")
            }
        }catch{
            print("Queery Error")
        }
        
        return returnUser
    }
    
    func retrieveUserRecord(user: String) -> User{
        let query = PFQuery(className:"_User")
        query.whereKey("username", equalTo: user as AnyObject)
        var returnUser = User()
        do{
            if let tmp : NSArray = try query.findObjects(){
                for usr in tmp{
                    returnUser = User(object: usr as! PFObject)
                }
            }else{
                print("No such items")
            }
        }catch{
            print("Queery Error")
        }
        
        return returnUser
    }
    
    func retriveDBMarkerImage(marker: Marker) -> UIImage{
        return retriveDBMarkerInfo(marker).getImage()
    }
    
   
    func retriveDBMarkerInfo(marker: Marker) -> Marker{
        let query = PFQuery(className:"MainDB")
        var mrkImageFile : PFFile
        query.whereKey("artId", equalTo: marker.getId() as AnyObject)
        do{
            if let tmp : NSArray = try query.findObjects(){
                for mkr in tmp{
                        marker.setInfoFromRecord(mkr as! PFObject)
                        mrkImageFile = mkr["image"] as! PFFile
                        if let img : NSData = try mrkImageFile.getData(){
                            marker.setImage(UIImage(data: img)!)
                        }

                    }
            }
        }catch{
            print("Query Error")
        }
        
        return marker
        
    }
    
    func retrieveLogin(email: String, password: String)throws -> Bool{
        let query = PFQuery(className: "_User")
        query.whereKey("email", equalTo: email as AnyObject)
        do{
            if let c : NSArray = try query.findObjects(){
                if c.count == 0 {
                    NSUserDefaults.standardUserDefaults().setObject("NOSUCHUSER", forKey: "username")
                    return false
                }else{
                    for f in c{
                        PFUser.logInWithUsernameInBackground(f["username"] as! String, password: password){
                            (user: PFUser?, error: NSError?) -> Void in
                            if user != nil {
                                do{
                                try PFUser.logInWithUsername(f["username"] as! String, password: password)
                                } catch{
                                    NSUserDefaults.standardUserDefaults().setObject("ERRORLOG", forKey: "error")
                                }
                            }else{
                                PFUser.logOut()
                            }
                        }
                    }
                }
            }
        }catch{
            print("Queery Error")
            return false
        }
        
        return true
    }
    
    func uploadNewReport(id: Int, position: CLLocationCoordinate2D, art: Art, visibility: String, geoAccuracy: CLLocationAccuracy, isInPosition: Bool){
        
        let newRecord = PFObject(className: "Report")
            
        newRecord["artId"] = id
        newRecord["author"] = art.getAuthor()
        newRecord["geoAccuracy"] = geoAccuracy
        if isInPosition{
            newRecord["isInPosition"] = "Yes"
        }else{
            newRecord["isInPosition"] = "No"
        }
        newRecord["latitude"] = position.latitude
        newRecord["longitude"] = position.longitude
        newRecord["status"] = visibility
        newRecord["title"] = art.getTitle()
        newRecord["username"] = PFUser.currentUser()!["username"] as! String
        newRecord["year"] = String(art.getYear())
        
        //UserController().retrieveByUsername(PFUser.currentUser()!["username"] as! String)?.addReport()
        
        newRecord.saveInBackgroundWithBlock{
            (success: Bool, error: NSError?) -> Void in
            if let error = error {
                _=error.userInfo["error"] as? NSString
            }
        }
        
    }
    
    
    func uploadNewUser(user: User, password : String){
        let usr = PFUser()
        usr.username = user.getUsername()
        usr.password = password
        usr["checkCounter"] = 0
        usr["checkIns"] = 0
        usr.email = user.getEmail()
        usr["phone"] =  "000000000"//non implementato
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
    
    /*func uploadUserParameter(username: String, parameter: String){
        let newParameter = PFQuery(className: "_User")
        newParameter.getObjectInBackgroundWithId(userId){
            (user: PFObject?, error: NSError?) -> Void in
            //Aggiorna valori parametri
        }
        
        newParameter
    }*/
}

