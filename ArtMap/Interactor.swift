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
    func retrieveArtistInformation(artistName : String) -> String{
        let query = PFQuery(className: "Artist")
        query.whereKey("artistName", containsString: artistName)
        
        var myInformation = ""
        
        do{
            if var tmp : [PFObject] = try query.findObjects(){
                if tmp.count > 0{
                    myInformation = tmp[0]["artistInformation"] as! String
                }
            }
        }catch{
            return "NOSUCHITEMS"
        }
        
        return myInformation
        
    }
    
    func retrieveArtistMappingOccurencies(artistName : String) -> Int{
        let query = PFQuery(className: "MainDB")
        query.whereKey("author", containsString: artistName)
        
        var occurencies = 0
        
        do{
            if var tmp : Array = try query.findObjects(){
                
                let size = tmp.count
                
                for index in 0...size - 1{
                    let control = tmp[index]["author"] as! String
                    if artistName.capitalizedString != control.capitalizedString {
                        tmp.removeAtIndex(index)
                    }
                }
                
                occurencies = tmp.count
            }
            
            
        }catch{
            print("No such items")
        }
        
        return occurencies
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
                    for user in c{
                        if user["username"] != nil {
                            do{
                                try PFUser.logInWithUsername(user["username"] as! String, password: password)
                            } catch{
                                print("LogIn failure")
                                return false
                            }
                        }else{
                            PFUser.logOut()
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
    func uploadNewArtistReport(artistInformation: String){
        if artistInformation != ""{
            let newRecord = PFObject(className: "Report")
            
            newRecord["username"] = PFUser.currentUser()!["username"] as! String
            newRecord["artistInformation"] = artistInformation
            
            updateUserInformation(0, checkIns: 0, reports: 1)
            
            newRecord.saveInBackground()
        }
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
        
        updateUserInformation(0, checkIns: 0, reports: 1)
        
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
    func uploadNewFBUser(user: User, idFB: String){
        let usr = PFUser()
        usr.username = user.getUsername()
        usr.password = ""
        usr["checkCounter"] = 0
        usr["checkIns"] = 0
        usr.email = user.getEmail()
        usr["phone"] =  "000000000"//non implementato
        usr["publishedPhotos"] = 0
        usr["reports"] = 0
        usr["votes"] = 0
        usr["idFB"] = idFB
        
        do{
            try usr.signUp()
        }catch{
            print("error signup")
        }
    }

    
    func uploadArt(username: String, location: CLLocationCoordinate2D, image: UIImage?, accuracy: Int, art: Art){
        
        let newRecord = PFObject(className: "Prova")
        newRecord["author"] = art.getAuthor()
        newRecord["geoAccuracy"] = accuracy
        newRecord["imageFile"] = PFFile(
            data: UIImageJPEGRepresentation(image!, 0.1)!)
        //newRecord["imageId"] = imageId
        newRecord["latitude"] = location.latitude
        newRecord["longitude"] = location.longitude
        newRecord["title"] = art.getTitle()
        newRecord["username"] = username
        newRecord["year"] = String(art.getYear())
        
        updateUserInformation(1, checkIns: 0, reports: 0)
        
        newRecord.saveInBackgroundWithBlock{
            (success: Bool, error: NSError?) -> Void in
            if let error = error {
                _=error.userInfo["error"] as? NSString
            }
        }
        
        
    }
    
    func updateUserInformation(publishedPhotos : Int, checkIns : Int, reports : Int){
        let currenteUser : PFObject = PFUser.currentUser()!
        
        if currenteUser["username"] == nil{
            return
        }
        
        let query = PFQuery(className: "_User")
        query.whereKey("objectId", equalTo: currenteUser.objectId!)
        
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
            if error == nil && object != nil{
                if(publishedPhotos != 0){
                    object!.incrementKey("publishedPhotos")
                }
                if checkIns != 0{
                    object!.incrementKey("checkIns")
                }
                if reports != 0{
                    object!.incrementKey("reports")
                }
                
                object?.saveInBackground()
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

