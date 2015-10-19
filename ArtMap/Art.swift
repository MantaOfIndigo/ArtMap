//
//  Art.swift
//  ArtMap
//
//  Created by Andrea Mantani on 29/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps
import Parse

class Art: NSObject {
    
    // title: Titolo
    // author: Autore opera
    // year: Anno di realizzazione
    // status: Visibile - true, Non visibile - false
    var title: String?
    var author: String?
    var year: Int?
    var visibility: Int?
    var tag : String?
    
    
    // COSTRUTTORI ----------------------------------------------
    
    override init(){
        self.title = ""
        self.author = ""
        self.year = 0
        self.visibility = 0
        self.tag = ""
        
        super.init()
    }
    
    //Costruttore per solo titolo
    init?(title:String){
        self.title = title
        self.author = ""
        self.year = 0
        self.visibility = 0
        self.tag = ""
        
        super.init()
    }
    //costruttore per titolo e autore
    init?(title:String, author:String){
        self.title = title
        self.author = author
        self.year = 0
        self.visibility = 0
        self.tag = ""
        
        super.init()
    }
    //costruttore per tutti gli attributi
    init?(title:String, author:String, year:Int){
        self.title = title
        self.author = author
        self.year = year
        self.visibility = 0
        self.tag = ""
        
        super.init()
    }
    init?(title:String, author:String, year:Int, status: Int){
        self.title = title
        self.author = author
        self.year = year
        self.visibility = status
        self.tag = ""
        
        super.init()
    }
    init?(object: PFObject){
        if let title = object["title"] as? String{
            self.title = title
        } else{
            self.title = ""
        }
        
        if let author = object["author"] as? String{
            self.author = author
        } else{
            self.author = ""
        }
        
        if let year = object["year"] as? Int{
            self.year = year
        } else{
            self.year = nil
        }
       
        if let visibility = object["visibility"] as? Int{
            self.visibility = visibility
        } else{
            self.visibility = nil
        }
        
        if let tag = object["tag"] as? String{
            self.tag = tag
        } else{
            self.tag = ""
        }
        
        super.init()
    }
    
    //------------------------------------------------------------
    
    func getFromMarker(marker: GMSMarker){
        
        
    
    }
    
    
}
