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
    
    @IBOutlet weak var logoutButton: UIButton!
    
    var presentedUser : User = User()
    
    @IBAction func cancelButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func logOut(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "username")
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = self.presentedUser.getUsername().uppercaseString
        checkins.text = String(self.presentedUser.getCheckins())
        publishedPhotos.text = String(self.presentedUser.getPublishedPhotos())
        reports.text = String(self.presentedUser.getReports())
        
        if NSUserDefaults.standardUserDefaults().stringForKey("username") != self.presentedUser.getUsername(){
            self.logoutButton.hidden = true
        }else{
            self.logoutButton.hidden = false
        }
        
    }
    override func viewDidAppear(animated: Bool) {
       
    }
    func setUserPage(user: User){
        self.presentedUser = user
    }
    
}
