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
    
    private var userController : UserController?
    private let permissions = [ "email","user_birthday", "public_profile", "user_friends"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        username.delegate = self
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        loginView.center = self.view.center
        //loginView.addTarget(self, action: Selector("fbLogPressed:"),forControlEvents: UIControlEvents.TouchDown)
        
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        self.view.addSubview(loginView)
        
    }
    
    
    /*func fbLogPressed(sender: FBSDKLoginButton){
        
        loginUIButton.enabled = false
        SignInUIButton.enabled = false
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions){
            (user: PFUser?, error: NSError?) -> Void in
            if error == nil && user != nil{
                print(user?.valueForKey("username"))
                if let user = user{
                    if (self.userController?.checkEmail(user["email"] as! String) == true){
                        Interactor().uploadNewUser(User(username: user.username!, email: user.email!), password: String(user.password))
                    }else{
                        if PFUser.currentUser() != nil{
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }else{
                            AlertLauncher().launchAlert("Login fallito", message: String(error!.userInfo), toView: self)
                        
                        }
                    }
                
                    self.loginUIButton.enabled = true
                    self.SignInUIButton.enabled = true
                }
            }
        }
    }*/
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil{
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        PFUser.logOut()
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        var email : String?
        var username : String?
      //  print(result)
        if error == nil{
            
            let fbRequest = FBSDKGraphRequest(graphPath:"me", parameters: nil, tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: "v2.3", HTTPMethod: nil)
            fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
                print(result)
                if error == nil {
                    let id = result.valueForKey("id") as? String
                    email = (result.valueForKey("email") as? String)! + ""
                    username = (result.valueForKey("name") as? String)!
                    
                    
                    
                    if id != nil && username != nil{
                        if self.userController?.checkUsername(username!) == true{
                            Interactor().uploadNewFBUser(User(username: username!, email: email!), idFB : id!)
                                self.userController?.addNewUserToList(User(username: username!, email: email!))
                        }else{
                            PFUser.logInWithUsernameInBackground(username!, password: "", block: { (user : PFUser?, error : NSError?) -> Void in
                                if user != nil{
                                    self.dismissViewControllerAnimated(true, completion: nil)
                                }else{
                                    AlertLauncher().launchAlert("Login Fallito", message: "Il login via Facebook è momentaneamente fuori servizio", toView: self)
                                }
                            })
                        }
                    }else{
                        AlertLauncher().launchAlertWithConfirm("Login Fallito", message: "Il login via Facebook è momentaneamente fuori servizio", toView: self)
                    }
                }else{
                    AlertLauncher().launchAlertWithConfirm("Login Fallito", message: "Il login via Facebook è momentaneamente fuori servizio", toView: self)
                }
                
                
            }
        }else {
            AlertLauncher().launchAlertWithConfirm("Login Fallito", message: "Il login via Facebook è momentaneamente fuori servizio", toView: self)
        }
        
    
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(self.permissions
            , block: { (user: PFUser?, error: NSError?) -> Void in
                print(PFUser.currentUser())
                if error == nil{
                    print(user?.valueForKey("username"))
                    print(user?.valueForKey("password"))
                }else{
                    AlertLauncher().launchAlert("Login Fallito", message: "Il login via Facebook è momentaneamente fuori servizio", toView: self)
                    return
                }
                
        })
    }
    
            //dismissViewControllerAnimated(true, completion: nil
    
    func setUserController(value : UserController){
        self.userController = value
    }
    
    @IBAction func exit(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func signIn(sender: AnyObject) {
        
        if PFUser.currentUser() == nil{
            if checkParameters(){
                let intrct = Interactor()
                let newUser = User(username: username.text!, email: email.text!)
                userController?.addNewUserToList(newUser)
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
            AlertLauncher().launchAlert( "Password non confermata", message: "Password ripetuta non correttamente", toView: self)
            return false
        }
        if password.text?.characters.count < 5 || password.text?.characters.count > 12{
            AlertLauncher().launchAlert("Formato password non corretto", message: "La password deve avere un minimo di 5 e un massimo di 12 caratteri", toView: self)
            return false
        }
        if AlertLauncher().isValidEmail(email.text!) == false {
            AlertLauncher().launchAlert("Email non valida", message: "Controlla che l'indirizzo sia esatto", toView: self)
            return false
        }
        if ((userController?.checkEmail(email.text!)) == false){
            AlertLauncher().launchAlert("Email non valida", message: "Questo indirizzo email è già stato utilizzato", toView: self)
            return false
        }else{
            
        }
        if ((userController?.checkUsername(username.text!)) == false){
            AlertLauncher().launchAlert("Username non valido", message: "Questo username è già stato utilizzato", toView: self)
            return false
        }
        
        return true
    }
    
    
    
    @IBAction func loginAction(sender: UIButton) {
        
        if PFUser.currentUser() == nil{
            do{
                if try Interactor().retrieveLogin(email.text!, password: password.text!)  ==  true{
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
