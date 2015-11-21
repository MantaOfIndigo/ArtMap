//
//  PrivacyController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 21/11/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

class PrivacyController : UIViewController{
    
    @IBOutlet weak var decorationView: UIView!
    
    @IBAction func exit(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        self.decorationView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
    }
}
