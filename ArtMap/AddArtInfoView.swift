//
//  AddInfoView.swift
//  ArtMap
//
//  Created by Andrea Mantani on 10/11/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

@objc class AddArtInfoView : UIViewController {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    
    func showInView(superView: UIView!, animated: Bool){
        superView.addSubview(self.view)
        if animated{
            self.showAnimate()
        }
    }
    
    func showAnimate(){
        self.view.alpha = 0
        UIView.animateWithDuration(0.20, animations: {
            self.view.alpha = 1
        })
    }
}
