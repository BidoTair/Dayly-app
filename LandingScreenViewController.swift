//
//  LandingScreenViewController.swift
//  Ephemeris - Daily Journal
//
//  Created by Abdulghafar Al Tair on 6/20/16.
//  Copyright © 2016 Abdulghafar Al Tair. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class LandingScreenViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    
    let loginManager = FBSDKLoginManager()
    var loginBool: Bool = false
    
    override func viewDidLoad() {
        print(PersistenceManager.loadObject("loginBool"))
        if PersistenceManager.loadObject("loginBool") != nil {
            loginBool = (PersistenceManager.loadObject("loginBool") as? Bool)!
        }
        if loginBool {
            self.navigateToMain()
        }
        else {
            super.viewDidLoad()
            self.navigationController?.navigationBarHidden = true
            var loginButton: FBSDKLoginButton = FBSDKLoginButton()
            loginButton.readPermissions = ["public_profile"]
            loginButton.center = self.view.center
            self.view!.addSubview(loginButton)
            // loginButton.readPermissions =
            loginButton.delegate = self
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult oresult: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("loggedin")
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        loginBool = true
        PersistenceManager.saveObject(loginBool, fileName: "loginBool")
        appDelegate.navigateToMainScreen()
    }
    
    func navigateToMain() {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigateToMainScreen()
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        loginManager.logOut()
    }
    

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
