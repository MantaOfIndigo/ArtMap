//
//  User.swift
//  ArtMap
//
//  Created by Andrea Mantani on 13/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

class User: NSObject {
    
    let name : String
    let surname : String
    var points : Int
    var picturesUploaded : Int
    var reports : Int
    var checkins : Int
    
     init(name : String, surname: String){
        self.name = name
        self.surname = surname
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
