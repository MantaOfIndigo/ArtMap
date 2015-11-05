//
//  LoginViewController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 14/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Parse
import ParseUI
import ParseFacebookUtilsV4

class LoginViewController : UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate  {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var loginUIButton: UIButton!
    @IBOutlet weak var SignInUIButton: UIButton!
    
    var userController : UserController?
    let launcher = AlertLauncher()
    let intrct = Interactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        username.delegate = self
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        loginView.center = self.view.center
        loginView.addTarget(self, action: Selector("fbLogPressed:"),forControlEvents: UIControlEvents.TouchDown)
        
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        self.view.addSubview(loginView)
        
    }
    
    let permissions = [ "email","user_birthday", "public_profile", "user_friends"]
    
    func fbLogPressed(sender: FBSDKLoginButton){
        
        loginUIButton.enabled = false
        SignInUIButton.enabled = false
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions){
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user{
                if (self.userController?.checkEmail(user["email"] as! String) == true){
                    self.intrct.uploadNewUser(User(username: user.username!, email: user.email!), password: String(user.password))
                }else{
                    print(user.password)
                }
                
                self.loginUIButton.enabled = true
                self.SignInUIButton.enabled = true
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil{
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        PFUser.logOut()
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
       
        
        if result != nil{
            dismissViewControllerAnimated(true, completion: nil)
        }else{
            AlertLauncher().launchAlert("Login fallito", message: String(error.userInfo), toView: self)
        }
    }
    
    func setUserList(value : UserController){
        self.userController = value
    }
    
    @IBAction func cancel(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func showPrivacy(sender: UIButton) {
        print("lancia view per privacy con testo")
    }
    @IBAction func signIn(sender: UIButton) {
        
        if PFUser.currentUser() == nil{
            if checkParameters(){
                let intrct = Interactor()
                let newUser = User(username: username.text!, email: email.text!)

                intrct.uploadNewUser(newUser, password: password.text!)
                do{
                try PFUser.logInWithUsername(newUser.getUsername(), password: password.text!)
                    dismissViewControllerAnimated(true, completion: nil)
                }catch{
                   print("SignIn error-")
                }
            
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
    }
    

    
    func checkParameters()-> Bool{
        if password.text != confirmPassword.text{
            launcher.launchAlert( "Password non confermata", message: "Password ripetuta non correttamente", toView: self)
            return false
        }
        if password.text?.characters.count < 5 || password.text?.characters.count > 12{
            launcher.launchAlert("Formato password non corretto", message: "La password deve avere un minimo di 5 e un massimo di 12 caratteri", toView: self)
            return false
        }
        if launcher.isValidEmail(email.text!) == false {
            launcher.launchAlert("Email non valida", message: "Controlla che l'indirizzo sia esatto", toView: self)
            return false
        }
        if ((userController?.checkEmail(email.text!)) == false){
            launcher.launchAlert("Email non valida", message: "Questo indirizzo email è già stato utilizzato", toView: self)
            return false
        }else{
            
        }
        if ((userController?.checkUsername(username.text!)) == false){
            launcher.launchAlert("Username non valido", message: "Questo username è già stato utilizzato", toView: self)
            return false
        }
        
        return true
    }
    
    
    
    @IBAction func loginAction(sender: UIButton) {
            let intrct = Interactor()
        
        if PFUser.currentUser() == nil{
            do{
                if try intrct.retrieveLogin(email.text!, password: password.text!)  ==  true{
                    dismissViewControllerAnimated(true, completion: nil)
                }else{
                    _ = AlertLauncher().launchAlert("Login Fallito", message: "La mail inserita non esiste", toView: self)
                }
            }catch{
                print("Query Error")
            }
        }
    }
   
    
   
}
