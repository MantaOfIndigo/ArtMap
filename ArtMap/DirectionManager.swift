//
//  DirectionManager.swift
//  ArtMap
//
//  Created by Andrea Mantani on 16/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class DirectionManager : NSObject{

    private var tour : Tour
    private var markersOfTour : [Marker]
    
    init(direction : [Marker], toView: UIViewController){
        tour = Tour(direction: direction, toView: toView)
        markersOfTour = direction
        super.init()
    }
    
    func getTourPolylines() -> [MKPolyline]{
        return self.tour.getRoutesPolylines()
    }
    func getTourBoundingRegion() -> [MKMapRect]{
        return self.tour.getRoutesBoundingRegions()
    }
    func getStepsCollection() -> [Step]{
        return self.tour.getStepCollection()
    }
    func getNumberOfSteps() -> Int{
        return self.tour.getNumberOfSteps()
    }
    func saveTour(){
        
        if self.markersOfTour.count <= 1{
            return
        }
        
        markersOfTour.removeFirst()
        
        var artistArray = [String]()
        
        for marker in markersOfTour{
            artistArray.append(marker.getArt().getAuthor())
        }
        
        let newElement : TourRecord = TourRecord(markers: markersOfTour, artists: artistArray)
        var tourList : [String]
        
        if let result = NSUserDefaults.standardUserDefaults().arrayForKey("tour"){
            tourList = result as! [String]
            tourList.append(newElement.toString())
            NSUserDefaults.standardUserDefaults().removeObjectForKey("tour")
            NSUserDefaults.standardUserDefaults().setObject(tourList, forKey: "tour")
        }else{
            tourList = [String]()
            tourList.append(newElement.toString())
            NSUserDefaults.standardUserDefaults().setObject(tourList, forKey: "tour")
        }
        
    }
}
