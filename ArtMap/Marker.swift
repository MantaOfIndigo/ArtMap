//
//  Marker.swift
//  ArtMap
//
//  Created by Andrea Mantani on 05/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps
import Parse

class Marker: NSObject {
   
    private var marker : GMSMarker
    private var id : Int = Int()
    private var image : UIImage
    private var user : String
    private var art : Art
    
    override init(){
        self.marker = GMSMarker()
        self.image = UIImage()
        self.art = Art(title: "", author: "", year: 0)!
        self.user = ""
        
        super.init()
    }
    init(position: CLLocationCoordinate2D, title: String, author: String, year: Int, visibility: Int){
        
        self.marker = GMSMarker()
        self.marker.icon = UIImage(named: "marker")
        self.marker.position = position
        self.marker.appearAnimation = kGMSMarkerAnimationPop
        self.marker.infoWindowAnchor = CGPointMake(0.44, 0.45);
        
        self.image = UIImage()
        self.user = ""
        self.art = Art(title: title, author: author, year: year, status: visibility)!
     
    }
    init(position: CLLocationCoordinate2D, id: Int){
        
        self.marker = GMSMarker()
        self.marker.icon = UIImage(named: "marker")
        self.marker.position = position
        self.marker.appearAnimation = kGMSMarkerAnimationPop
        self.marker.infoWindowAnchor = CGPointMake(0.44, 0.45);
        
        self.image = UIImage()
        self.id = id
        self.art = Art()
        self.user = ""
        
        
    }
    func setImage(value: UIImage){
        self.image = value
    }
    func setInfoFromRecord(value: PFObject){
        
        self.art = Art(object: value)!
        self.user = value["user"] as! String
    }
    func setArt(value: Art){
        self.art = value
    }
    func getMarker() -> GMSMarker{
        return self.marker
    }
    /*func getId() -> Int{
        return self.id
        
    }*/
    func getImage() -> UIImage{
        return self.image
    }
    func getId() -> Int{
        return self.id
    }
    func getArt() -> Art{
        return self.art
        
    }
    func getUser() -> String{
        return self.user
    }

}
