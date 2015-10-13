//
//  Marker.swift
//  ArtMap
//
//  Created by Andrea Mantani on 04/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps

class MarkerController: NSObject {
    
    
    var markerList : [Marker] = [Marker]()
    // devo creare un oggetto che contenga GMSMarker, immagine e identificativo
    // da passare nella lista di ritorno
    override init(){
        super.init()
        markerList = getList()
    }
    
    private func getList() -> [Marker]{
        var tmpList = [Marker]()
        
        let m = Marker(position: CLLocationCoordinate2DMake(21.304080, -157.733396), id: 1, image: UIImage(named: "logo")!, title: "Giancy", author: "Alexander Mant", year: 2015, status: true)
        
        let d = Marker(position: CLLocationCoordinate2DMake(21.357168, -157.857679), id: 1, image: UIImage(named: "profile")!,  title: "Gianal", author: "Pago", year: 2014, status: false)
        
        tmpList.append(m)
        tmpList.append(d)
        return tmpList
    }
    
    func getImageFromMarker(marker: GMSMarker) -> UIImage?{
        for index in 0...markerList.count{
            if markerList[index].getMarker().isEqual(marker){
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

}
