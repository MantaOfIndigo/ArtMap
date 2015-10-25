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
    
    func saveUser(exist: Bool)-> Bool{
        // se presente aggiorni nuovi dati
        // se nuovo aggiungilo a database
        
        return false
    }
    
    func getUsername() -> String{
        return self.username
    }
    func getEmail() -> String{
        return self.email
    }

}
