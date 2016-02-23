//
//  DirectionTableCell.swift
//  ArtMap
//
//  Created by Andrea Mantani on 17/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit

class DirectionTableCell : UIView{
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var lblInstructions: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSBundle.mainBundle().loadNibNamed("DirectionTableCell", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    func setLabels(distance : String, instructions: String){
        self.lblDistance.text = "Distance: " + distance + " meters"
        self.lblInstructions.text = instructions
    }
}