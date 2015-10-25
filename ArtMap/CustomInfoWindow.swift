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
    var viewImage : UIImage = UIImage()
    
    func prepareImage (image : UIImage){
        self.viewImage = image
    }
    
}
