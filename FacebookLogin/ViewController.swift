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
import FBSDKShareKit

class ViewController: UIViewController , FBSDKLoginButtonDelegate
{
    //使用者大頭貼
    @IBOutlet weak var userImage: FBSDKProfilePictureView!
    //FB登入按鈕
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    //顯示登入狀態
    @IBOutlet weak var loginInfo: UILabel!
    //使用者姓名
    @IBOutlet weak var userName: UILabel!
    //使用者Email
    @IBOutlet weak var userEmail: UILabel!
    //分享按鈕
    @IBOutlet weak var shareButton: FBSDKShareButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loginButton.delegate = self
        
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "https://github.com/tabhuang/FacebookLogin")
        content.contentTitle = "Swift"
        content.contentDescription = "Facebook Login & Share"
        content.imageURL = NSURL(string: "https://raw.githubusercontent.com/tabhuang/FacebookLogin/master/3.png")
        shareButton.shareContent = content
        shareButton.enabled = false
        
        if((FBSDKAccessToken.currentAccessToken()==nil))
        {
            println("Not logged in..")
            loginInfo.text = "Not logged in.."
            userName.text = "UserName"
            userEmail.text = "UserEmail"
            shareButton.enabled = false
        }
        else
        {
            println("Logged in..")
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            showUserInfo()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Facebook Login
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {

        if error == nil
        {
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            loginButton.delegate = self
            println("Login complete.")
            showUserInfo()
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else
        {
            println(error.localizedDescription)
        }
    }
    
    //使用者點選登出
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        println("User logged out...")
        loginInfo.text = "Not logged in.."
        userName.text = "UserName"
        userEmail.text = "UserEmail"
        shareButton.enabled = false
    }

    //顯示使用者資料
    func showUserInfo()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")
                self.loginInfo.text = "Logged in.."
                self.userName.text = userName as String
                self.userEmail.text = userEmail as String
                self.shareButton.enabled = true
            }
        })
    }
}

