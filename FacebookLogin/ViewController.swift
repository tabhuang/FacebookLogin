//
//  ViewController.swift
//  FacebookLogin
//
//  Created by Huang Jian-Yu on 2015/6/26.
//  Copyright (c) 2015年 Zitra. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController , FBSDKLoginButtonDelegate
{
    
    @IBOutlet weak var userImage: FBSDKProfilePictureView!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if((FBSDKAccessToken.currentAccessToken()==nil))
        {
            println("Not logged in..")
        }
        else
        {
            println("Logged in..")
        }
        
        //var loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Facebook Login
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error == nil
        {
            println("Login complete.")
            self.performSegueWithIdentifier("showNew", sender: self)
        }
        else
        {
            println(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User logged out...")
    }

}

