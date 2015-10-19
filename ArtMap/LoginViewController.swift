//
//  LoginViewController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 14/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Parse

class LoginViewController : UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        username.delegate = self
        
    }
    
    @IBAction func cancel(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func showPrivacy(sender: UIButton) {
        print("privacy di merda")
    }
    @IBAction func signIn(sender: UIButton) {
        /*
        let lista = PFObject(className: "ClassListaUtenti")
        
        lista["user"] = username.text
        lista["email"] = email.text
        lista["password"] = password.text
        
        lista.saveInBackgroundWithBlock{ (Bool, NSError) -> Void in
            if NSError == nil{
                print("salvato")
            }
        }*/
    }
    @IBAction func login(sender: UIButton) {
         print("login")
    }
}
