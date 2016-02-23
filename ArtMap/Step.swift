//
//  Step.swift
//  ArtMap
//
//  Created by Andrea Mantani on 16/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps

class Step : NSObject{
    
    private var distance : Double
    private var instructions : String
    
    init(distance : Double,instructions: String){
        self.distance = distance
        self.instructions = instructions
        super.init()
    }

    init(step: NSMutableDictionary){
        self.distance = step["distance"] as! Double
        self.instructions = step["instructions"] as! String
    }
    
    func getDistance()-> Double{
        return self.distance
    }
    
    func getInstructions() -> String{
        return self.instructions
    }
}
