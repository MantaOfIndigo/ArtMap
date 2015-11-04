//
//  User.swift
//  ArtMap
//
//  Created by Andrea Mantani on 13/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {
    
    private let idUser : String?
    private let username : String
    private let email : String
    private var points : Int
    private var picturesUploaded : Int?
    private var reports : Int?
    private var checkins : Int?
    private var checkCounter : Int?
    
    override init(){
        self.idUser = ""
        self.username = ""
        self.email = ""
        self.points = 0
        self.checkCounter = 0
        self.checkins = 0
        self.picturesUploaded = 0
        self.reports = 0
        super.init()
    }
    
    init(username : String){
        self.idUser = ""
        self.username = username
        self.email = ""
        self.points = 0
        self.checkCounter = 0
        self.checkins = 0
        self.picturesUploaded = 0
        self.reports = 0
        super.init()
    }
    
    init(username : String, email : String){
        self.idUser = ""
        self.username = username
        self.email = email
        self.points = 0
        self.checkCounter = 0
        self.checkins = 0
        self.picturesUploaded = 0
        self.reports = 0
        super.init()
    }
    
    init(object: PFObject){
        
        self.username = object["username"] as! String
        self.email = object["email"] as! String
        self.picturesUploaded = object["publishedPhotos"] as? Int
        self.reports = object["reports"] as? Int
        self.checkins = object["checkIns"] as? Int
        self.checkCounter = object["checkCounter"] as? Int
        self.idUser = object["objectId"] as? String
        self.points = 0
        super.init()
        self.calculatePoint()
    }
    
    func calculatePoint(){
        if self.picturesUploaded != nil{
        self.points = self.picturesUploaded! * 100
        }
        // altre formule per i punti
    }
    
    func addReport(){
        if self.reports != nil{
            self.reports = self.reports! + 1
        }
    }
    
    func addPublishedPhoto(){
        if self.picturesUploaded != nil{
            self.picturesUploaded = self.picturesUploaded! + 1
        }
    }
    
    func addCheckins(){
        if self.checkins != nil{
            self.checkins = self.checkins! + 1
        }
    }
    
    func addCheckCounter(){
        if self.checkCounter != nil{
            self.checkCounter = self.checkCounter! + 1
        }
    }
    
    func getUsername() -> String{
        return self.username
    }
    func getEmail() -> String{
        return self.email
    }
    func getCheckins() -> Int{
        if self.checkins == nil{
            return 0
        }
        return self.checkins!
    }
    func getPublishedPhotos() -> Int{
        if self.picturesUploaded == nil{
            return 0
        }
        return self.picturesUploaded!
    }
    func getReports() -> Int{
        if self.reports == nil{
            return 0
        }
        return self.reports!
    }
    func compareUsernames(compare: String)-> Bool{
        let tmpStr : String
        let comparator : String
        
        if compare.characters.count > self.username.characters.count{
            tmpStr = compare
            comparator = self.username
        }else{
            tmpStr = self.username
            comparator = compare
        }
        
        let range = tmpStr.startIndex..<tmpStr.endIndex.advancedBy(-1)
        let sub = tmpStr[range]
        
        if sub == comparator{
            return true
        }
        
        return false
    }

}
