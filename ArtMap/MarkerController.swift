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
    
    
    var tmp = [Marker]()
    // devo creare un oggetto che contenga GMSMarker, immagine e identificativo
    // da passare nella lista di ritorno
    override init(){
        super.init()
    }
    
    internal func getList() -> [Marker]{
        let m = Marker(position: CLLocationCoordinate2DMake(21.304080, -157.733396), id: 1, image: UIImage(named: "logo")!, title: "Giancy", author: "Alexander Mant", year: 2015, status: true)
        
        let d = Marker(position: CLLocationCoordinate2DMake(21.357168, -157.857679), id: 1, image: UIImage(named: "profile")!,  title: "Gianal", author: "Pago", year: 2014, status: false)
        
        tmp.append(m)
        tmp.append(d)
        return tmp
    }
    
    func getImageFromMarker(marker: GMSMarker) -> UIImage?{
        for index in 0...tmp.count{
            if tmp[index].getMarker().isEqual(marker){
                return tmp[index].getImage()
            }
        }
        
        return nil
    }
    
    func getMarker(marker:GMSMarker) -> Marker?{
        for index in 0...tmp.count{
            if tmp[index].getMarker().isEqual(marker){
                return tmp[index]
            }
        }
        
        return nil
    }

}
