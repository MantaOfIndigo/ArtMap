//
//  Marker.swift
//  ArtMap
//
//  Created by Andrea Mantani on 05/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps

class Marker: NSObject {
    
    private var marker : GMSMarker
    private var id : Int
    private var image : UIImage
    private var art : Art
    
    override init(){
        self.marker = GMSMarker()
        self.image = UIImage()
        self.art = Art(title: "", author: "", year: 0)!
        self.id = 0
        super.init()
    }
    init(position: CLLocationCoordinate2D, id: Int, image: UIImage, title: String, author: String, year: Int, status: Bool){
        
        self.marker = GMSMarker()
        self.marker.icon = UIImage(named: "marker")
        self.marker.position = position
        self.marker.appearAnimation = kGMSMarkerAnimationPop
        self.marker.infoWindowAnchor = CGPointMake(0.44, 0.45);
        
        self.image = image
        self.id = id
        
        self.art = Art(title: title, author: author, year: year, status: status)!
     
    }
    func getMarker() -> GMSMarker{
        return self.marker
    }
    func getId() -> Int{
        return self.id
        
    }
    func getImage() -> UIImage{
        return self.image
    }
    
    func getArt() -> Art{
        return Art(title: self.art.title, author: self.art.author, year: self.art.year, status: self.art.status)!
        
    }

}
