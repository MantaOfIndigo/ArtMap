//
//  AddInfoView.swift
//  ArtMap
//
//  Created by Andrea Mantani on 10/11/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import QuartzCore

 @objc class AddArtInfoView : UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var stackButtonArea: UIStackView!
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var visible: UISwitch!
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    var status = Int()
    
    var uploadingMarkerLocation = CLLocationCoordinate2D()
    var uploadingImage = UIImage()
    var uploadingAccuracy = Int()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.view.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        self.innerView.layer.shadowOpacity = 0.8
        self.innerView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        titleText.delegate = self
        authorText.delegate = self
        yearText.delegate = self
        
        visible.setOn(true, animated: false)
        visible.addTarget(self, action: Selector("switchChanged:"), forControlEvents:UIControlEvents.ValueChanged)
        self.sendButton.titleLabel?.text = "mannaggamado"
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
    
    func switchChanged(setStatus: UISwitch){
        if visible.on{
            status = 1
            print("turn on")
        }else{
            status = 0
        }
    }
    
    func send(sender: UIButton) {
        let art : Art
        if (Int(yearText.text!) != nil){
            art = Art(title: titleText.text!, author: authorText.text!, year: 0, status: status)!
        }else{
            art = Art(title: titleText.text!, author: authorText.text!, year: Int(yearText.text!)!, status: status)!
        }
        
        Interactor().uploadArt((PFUser.currentUser()?.username)!, location: uploadingMarkerLocation, image: uploadingImage, accuracy: uploadingAccuracy, art: art)

    }
    
    @IBAction func sendArt(sender: UIButton) {
        print("chitemmuort")
    }
    
    @IBAction func backAction(sender: UIButton) {
        print("cicc")
    }
    
    func locationToUpload(location: CLLocationCoordinate2D, accuracy: Int, image: UIImage){
        self.uploadingMarkerLocation = location
        self.uploadingImage = image
        self.uploadingAccuracy = accuracy
    }
}
