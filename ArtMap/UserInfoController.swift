//
//  UserInfoController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 29/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

class UserInfoController: UIViewController, UINavigationControllerDelegate{
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var checkins: UILabel!
    @IBOutlet weak var publishedPhotos: UILabel!
    @IBOutlet weak var reports: UILabel!
    
    var currentUser : User = User()
    
    @IBAction func cancelButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func logOut(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "username")
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = self.currentUser.getUsername().uppercaseString
        checkins.text = String(self.currentUser.getCheckins())
        publishedPhotos.text = String(self.currentUser.getPublishedPhotos())
        reports.text = String(self.currentUser.getReports())
        
    }
    
    func setUserPage(user: User){
        self.currentUser = user
    }
    
}
