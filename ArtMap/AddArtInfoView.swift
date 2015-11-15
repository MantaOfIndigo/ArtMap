//
//  AddArtInfoView.swift
//  ArtMap
//
//  Created by Andrea Mantani on 15/11/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

class AddArtInfoView: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var visible: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.view.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
       
    }
    
  
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    @IBAction func sender(sender: UIButton) {
        print("daaaaiii")
    }
    
    @IBAction func exit(sender: UIButton) {
    }
    
    func locationToUpload(position: CLLocationCoordinate2D, accuracy: Int, image: UIImage){
    
    }
    
}
