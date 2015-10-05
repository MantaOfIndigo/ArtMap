//
//  CustomInfoWindow.swift
//  ArtMap
//
//  Created by Andrea Mantani on 04/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

class CustomInfoWindow: UIView {

    @IBOutlet weak var image: UIImageView!
    
    @IBAction func showImage(sender: UITapGestureRecognizer) {
        var popview = ArtInfoView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        popview
        ArtInfoView.beginAnimations(nil, context: nil)
        ArtInfoView.setAnimationDuration(0.3)
        ArtInfoView.commitAnimations()
        
    }
}
