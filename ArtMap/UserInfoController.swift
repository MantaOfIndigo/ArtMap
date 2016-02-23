//
//  UserInfoController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 29/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

class UserInfoController: UIViewController{
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var checkins: UILabel!
    @IBOutlet weak var publishedPhotos: UILabel!
    @IBOutlet weak var reports: UILabel!
    @IBOutlet weak var points: UILabel!
    
    @IBOutlet weak var tourButton: UIBarButtonItem!
    @IBOutlet weak var logoutButton: UIButton!
    
    private var presentedUser : User = User()
    
    @IBAction func exit(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func logOut(sender: UIButton) {
        //NSUserDefaults.standardUserDefaults().setObject("NOLOGGED", forKey: "username")
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        PFUser.logOut()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = self.presentedUser.getUsername().uppercaseString
        checkins.text = String(self.presentedUser.getCheckins())
        publishedPhotos.text = String(self.presentedUser.getPublishedPhotos())
        reports.text = String(self.presentedUser.getReports())
        points.text = String(self.presentedUser.getPoints())
        if PFUser.currentUser() == nil{
            self.logoutButton.hidden = true
        }else{
            if self.presentedUser.getUsername() == PFUser.currentUser()!["username"] as! String{
                self.logoutButton.hidden = false
                self.tourButton.enabled = true
            }else{
                self.tourButton.enabled = false
                self.logoutButton.hidden = true
            }
        }
    }

    func setUserPage(user: User){
        self.presentedUser = Interactor().retrieveUserRecord(user.getUsername())
        if presentedUser.getUsername() == ""{
            presentedUser = User(username: user.getUsername())
        }
        
        
    }
    
}
