//
//  Art.swift
//  ArtMap
//
//  Created by Andrea Mantani on 29/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps

class Art: NSObject {
    
    // title: Titolo
    // author: Autore opera
    // year: Anno di realizzazione
    // status: Visibile - true, Non visibile - false
    var title: String
    var author: String
    var year: Int
    var status: Bool
    
    struct Property{
        static let titleKey = "title"
        static let authorKey = "author"
        static let yearKey = "year"
        static let stateKey = "status"
    }
    
    // COSTRUTTORI ----------------------------------------------
    
    //Costruttore per solo titolo
    init?(title:String){
        self.title = title
        self.author = ""
        self.year = 0
        self.status = true
        
        super.init()
    }
    //costruttore per titolo e autore
    init?(title:String, author:String){
        self.title = title
        self.author = author
        self.year = 0
        self.status = true
        
        super.init()
    }
    //costruttore per tutti gli attributi
    init?(title:String, author:String, year:Int){
        self.title = title
        self.author = author
        self.year = year
        self.status = true
        
        super.init()
    }
    init?(title:String, author:String, year:Int, status: Bool){
        self.title = title
        self.author = author
        self.year = year
        self.status = status
        
        super.init()
    }
    
    //------------------------------------------------------------
    
    func getFromMarker(marker: GMSMarker){
        
        
    
    }
    
    
}
