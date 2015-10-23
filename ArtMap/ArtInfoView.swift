//
//  ArtInfoView.swift
//  ArtMap
//
//  Created by Andrea Mantani on 05/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import QuartzCore

 @objc class ArtInfoView : UIViewController{
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var imageInfo: UIImageView!
    @IBOutlet weak var decorationView: UIView!
    @IBOutlet weak var bottomArea: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    
    private var artInformation : Marker = Marker()
    
    
    @IBAction func openForm(sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newView : FormArtController = storyboard.instantiateViewControllerWithIdentifier("formInterface") as! FormArtController
        
        newView.setForm(artInformation)
        
        newView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(newView, animated: true, completion: nil)
    }
    
    @IBAction func exit(sender: UIButton) {
        removeAnimate()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.imageInfo.image = artInformation.getImage()
        decorationView.layer.borderColor = UIColor.whiteColor().CGColor
        decorationView.layer.borderWidth = 2
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.view.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        self.infoView?.layer.shadowOpacity = 0.8
        self.infoView?.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        self.authorLabel.text = artInformation.getUser().getSurname()
    
        
    }
    
    func showInView(superView: UIView!, animated: Bool, image: UIImage!){
        superView.addSubview(self.view)
        self.imageInfo?.image = artInformation.getImage()
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
    
    func removeAnimate(){
        UIView.animateWithDuration(0.20, animations: {
                self.view.alpha = 0
            }, completion: {
                (finished: Bool) in
                self.view.removeFromSuperview()
        })
    }
    
    func setInformation(info: Marker){
        self.artInformation = info
    }

}
