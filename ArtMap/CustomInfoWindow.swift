//
//  CustomInfoWindow.swift
//  ArtMap
//
//  Created by Andrea Mantani on 04/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

class CustomInfoWindow: UIView{

    @IBOutlet weak var image: UIImageView!
    
 
    @IBAction func showInfo(sender: AnyObject) {
        let popview = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        popview.backgroundColor = UIColor.greenColor()
        popview.layer.cornerRadius = 23
        popview.layer.borderWidth = 2
        self.addSubview(popview)
    }
 
}
