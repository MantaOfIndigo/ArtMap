//
//  Route.swift
//  ArtMap
//
//  Created by Andrea Mantani on 17/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class Route : NSObject{
    private var route : [Step]
    private var polyLine : MKPolyline
    private var boundingRegion : MKMapRect
    //private var viewToPopulate : TourIndicationController
    
    init(from: Marker, to: Marker, toView: UIViewController){
        self.route = [Step]()
        self.polyLine = MKPolyline()
        self.boundingRegion = MKMapRect()
        super.init()
        
        createStep(from.getMarker().position, to: to.getMarker().position, viewToPopulate: toView)
        //self.steps.append(Step(from: direction[0], to: direction[1]))
        
    }
    
    func createStep(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, viewToPopulate : UIViewController){
        
        let mapManager = MapManager()
        
        mapManager.directions(from: from, to: to) { (route, directionInformation, boundingRegion, error) -> () in
            
            
            let sendToView = viewToPopulate as! IndicatorView
            
            if(route != nil){
                self.polyLine = route!
                self.boundingRegion = boundingRegion!
            
                var distance : Double
                var instructions : String
                if error == nil{
                    for index in 0...directionInformation!["steps"]!.count - 1{
                        distance = Double(directionInformation!["steps"]![index]["distance"] as! String)!
                        instructions = directionInformation!["steps"]![index]["instructions"] as! String
                        self.route.append(Step(distance: distance, instructions: instructions))
                    }
                }
                
                sendToView.addOverlay(self.polyLine, boundingRegion: self.boundingRegion, steps: self.route)
                
            }else{
                sendToView.addOverlay(self.polyLine, boundingRegion: self.boundingRegion, steps: self.route)
                
            }
        }
    }
    
    func getRoute() -> [Step]{
        return self.route
    }
    
    func getRoutePolyline() -> MKPolyline{
        return self.polyLine
    }
    
    func getStepsNumber()->Int{
        print(route.count)
        return self.route.count
    }
    func getBoundingRegion() -> MKMapRect{
        print(boundingRegion.size)
        return self.boundingRegion
    }
    
}
