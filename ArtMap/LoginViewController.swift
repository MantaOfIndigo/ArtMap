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

class LoginViewController : UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var username: UITextField!
    
    var userController : UserController?
    let launcher = AlertLauncher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        username.delegate = self
        
        //if FBSDKAccessToken.currentAccessToken() == nil{
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
            self.view.addSubview(loginView)
            
        //}
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        NSUserDefaults.standardUserDefaults().setObject("NOSUCHUSER", forKey: "username")
    }
    
    func returnUserData(){
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if(error != nil){
                print("Error")
            }else{
                let userName : NSString = result.valueForKey("name") as! NSString
                print(userName)
                let userMail : NSString = result.valueForKey("email") as! NSString
                print(userName, "  ", userMail )
                if ((self.userController?.checkEmail(userMail as String)) == true){
                    let intrct = Interactor()
                    intrct.uploadNewUser(User(username: userName as String, email: userMail as String), password: result.valueForKey("password") as! String)
                }
                
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "username")
            }
        })
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        let alert : AlertLauncher = AlertLauncher()
        if error != nil{
            alert.launchAlert("Login fallito", message: "Si è verificato un errore nella connessione con Facebook", toView: self)
        }else if result.isCancelled{
            alert.launchAlert("Login fallito", message: "Risultato cancellato", toView: self)
        }else{
            if result.grantedPermissions.contains("email"){
                returnUserData()
            }
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
        
        if checkParameters(){
            //carica
            let intrct = Interactor()
            let newUser = User(username: username.text!, email: email.text!)
            intrct.uploadNewUser(newUser, password: password.text!)
            NSUserDefaults.standardUserDefaults().setObject(newUser.getUsername(), forKey: "username")
            
            dismissViewControllerAnimated(true, completion: nil)
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
        do{
            if try intrct.retrieveLogin(email.text!, password: password.text!)  == true{
                dismissViewControllerAnimated(true, completion: nil)
            }
        }catch{
            print("Query Error")
        }

    }
   
    
   
}
