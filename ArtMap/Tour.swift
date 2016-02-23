//
//  Tour.swift
//  ArtMap
//
//  Created by Andrea Mantani on 16/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class Tour : NSObject{
    private var tour : [Route]
    private var routePolylines : [MKPolyline]
    private var routeBoundingRegions : [MKMapRect]
    //private var viewToPopulate : UIViewController
    private var numberOfSteps : Int
    
    init(direction : [Marker], toView: UIViewController){
        self.tour = [Route]()
        self.routePolylines = [MKPolyline]()
        self.routeBoundingRegions = [MKMapRect]()
        //self.viewToPopulate = toView
        self.numberOfSteps = 0
        super.init()
        createTour(direction, viewToPopulate: toView)//self.steps.append(Step(from: direction[0], to: direction[1]))
        
    }
    
    func createTour(direction: [Marker], viewToPopulate : UIViewController){
        for index in 0...direction.count-1{
            if direction.count != index + 1{
                self.tour.append(Route(from: direction[index], to: direction[index+1], toView : viewToPopulate))
            }
        }
    }
    
    func getRoutesPolylines() -> [MKPolyline]{
        return routePolylines
    }
    func getRoutesBoundingRegions() -> [MKMapRect]{
        return routeBoundingRegions
    }
    func getNumberOfSteps() -> Int{
        return self.numberOfSteps
    }
    func getStepCollection() -> [Step]{
        var stepsCollection = [Step]()
        
        for index in 0...tour.count-1{
            stepsCollection.appendContentsOf(self.tour[index].getRoute())
        }
        
        
        return stepsCollection
    }
    
    func setObject(route: Route, line: MKPolyline, bounding : MKMapRect, numberSteps: Int){
        self.tour.append(route)
        self.routePolylines.append(line)
        self.routeBoundingRegions.append(bounding)
        self.numberOfSteps += numberSteps
        print("steoss")
        print(numberOfSteps)
        print("passaggi")
        print(route.getRoute()[0].getInstructions())
    }
    
    
}
