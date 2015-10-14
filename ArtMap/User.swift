//
//  User.swift
//  ArtMap
//
//  Created by Andrea Mantani on 13/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

class User: NSObject {
    
    let username : String
    let password : String
    let email : String
    var points : Int
    var picturesUploaded : Int
    var reports : Int
    var checkins : Int
    
    init(username : String, password: String, email: String){
        self.username = username
        self.password = password
        self.email = email
        self.points = 0
        self.picturesUploaded = 0
        self.reports = 0
        self.checkins = 0
        
        super.init()
    }
    
    func calculatePoint(){
        self.points = self.picturesUploaded * 100
        // altre formule per i punti
    }
    
    func saveUser(exist: Bool)-> Bool{
        // se presente aggiorni nuovi dati
        // se nuovo aggiungilo a database
        
        return false
    }

}
