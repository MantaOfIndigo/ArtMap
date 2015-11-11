//
//  Art.swift
//  ArtMap
//
//  Created by Andrea Mantani on 29/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
//import GoogleMaps
import Parse

class Art: NSObject {
    
    // title: Titolo
    // author: Autore opera
    // year: Anno di realizzazione
    // visibility: 0 danneggiato - 1 visibile - 2 rimosso
    private var title: String?
    private var author: String?
    private var year: Int?
    private var visibility: Int?
    private var tag : String?
    
    
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
    init?(title:String?, author:String?, year:Int?){
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
    
    func getTitle() -> String!{
        if self.title == nil{
            return ""
        }
        return self.title!
    }
    func getAuthor() -> String!{
        if self.author == nil{
            return ""
        }
        return self.author!
    }
    func getYear() -> Int!{
        if self.year == nil{
            return 0
        }
        return self.year!
    }
    func getState() -> Int!{
        if self.visibility == nil{
            return 1
        }
        return self.visibility!
    }
    func getTag() -> String!{
        if self.tag == nil{
            return ""
        }
        return self.tag!
    }
    
    
}
