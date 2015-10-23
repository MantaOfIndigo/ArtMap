//
//  Marker.swift
//  ArtMap
//
//  Created by Andrea Mantani on 04/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps
import Parse

class MarkerController: NSObject {
    
    
    var markerList : [Marker] = [Marker]()
    // devo creare un oggetto che contenga GMSMarker, immagine e identificativo
    // da passare nella lista di ritorno
    override init(){
        super.init()
    }
    // formato record
    /*
        artId   author  image   latitude    longitude    tag    title   user    visibility  year
        int     string  UIImage double      double       string string  string  bool        int
    */
    func createList(object: PFObject) -> Marker{
            let loc = CLLocationCoordinate2DMake(object["latitude"] as! Double, object["longitude"] as! Double)
        let tmp = Marker(position: loc, id: object["artId"] as! Int)
        
        if object["user"] == nil{
            tmp.setUser(User(username: "(undefined)"))
        }else
        {
            tmp.setUser(User(username: object["user"] as! String))
        }
        
        markerList.append(tmp)
        
            return tmp
            
    }
    
    func getImageFromMarker(marker: Marker) -> UIImage?{
        for index in 0...markerList.count{
            if markerList[index].isEqual(marker){
                return markerList[index].getImage()
            }
        }
        
        return nil
    }
    
    func getMarker(marker:GMSMarker) -> Marker?{
        for index in 0...markerList.count{
            if markerList[index].getMarker().isEqual(marker){
                return markerList[index]
            }
        }
        
        return nil
    }
    
    func getMarkerList() -> [Marker]?{
        if markerList.count == 0{
            return nil
        }
        return markerList
    }
    
    func linkUser(userList: [User]) -> Bool{
        print(userList.count)
        print(markerList.count)
        for user in userList{
            for marker in self.markerList{
                if user.getSurname() == marker.getUser().getSurname(){
                    marker.setUser(user)
                }
            }
        }
        
        return false
    }

}
