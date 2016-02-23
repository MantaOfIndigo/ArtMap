//
//  TourRecord.swift
//  ArtMap
//
//  Created by Andrea Mantani on 18/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit
import CoreLocation

class TourRecord : NSObject{
    
    private var markers : [Marker]
    private var artists : [String]
   
    
    init(markers : [Marker], artists: [String]){
        self.markers = markers
        self.artists = artists
    }
    
    init(fromString: String){
        self.markers = [Marker]()
        self.artists = [String]()
        super.init()
        
        var getString = fromString.stringByReplacingOccurrencesOfString("}", withString: "")
        
        let subAttribute = fromString.componentsSeparatedByString("{")
        
        let subMarker = subAttribute[1].componentsSeparatedByString(",")
        
        for str in subMarker{
            if str.componentsSeparatedByString(":").count == 2{
                //print(str)
            let lat = Double(str.componentsSeparatedByString(":")[0])
            let long = Double(str.componentsSeparatedByString(":")[1])
            
            self.markers.append(Marker(position: CLLocationCoordinate2D(latitude: lat!, longitude: long!), id: 0))
            }
        }
        
        //print(self.markers.count)
        
        let subArtist = subAttribute[2].componentsSeparatedByString(":")
        
        for arts in subArtist{
            if arts != "" && arts != "}"{
                self.artists.append(arts)
            }
        }
        
    }
    
    func getDirections() -> [Marker]{
        return self.markers
    }
    
    func getArtist() -> [String]{
        return self.artists
    }
    
    func toString() -> String{
        var markerString = "marker {"
        for mark in markers{
            markerString += String(mark.getMarker().position.latitude) + ":" + String(mark.getMarker().position.longitude) + ","
        }
        markerString += "}"
        
        var artistString = " artist {"
        
        for arts in artists{
            artistString += arts + ":"
        }
        artistString += "}"
        
        print("creata string -------------")
        print(markerString + artistString)
        print("---------------------------")
        
        return markerString + artistString
    }
}
