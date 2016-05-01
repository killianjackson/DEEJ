//
//  LoginVC.swift
//  DEEJ
//
//  Created by Killian Jackson on 4/30/16.
//  Copyright © 2016 Killian Jackson. All rights reserved.
//

import UIKit
import Foundation

class LoginVC: UIViewController/*, SPTAuthViewDelegate*/ {
    
    @IBOutlet weak var spotifyLogin: MaterialView!
    
    var session:SPTSession!
    var firstLoad =  false
    let authViewController = SPTAuthViewController.authenticationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserverForName("LoginSuccess", object: nil, queue: nil) { (NSNotification) in
            self.spotifyLogin.hidden = true
            self.performSegueWithIdentifier("LoggedIn", sender: self)
        }
        let userDefaults = NSUserDefaults.standardUserDefaults()
        print("viewDidLoad")
        if let sessionObj = userDefaults.objectForKey("SpotifySession") {
            let sessionDataObj = sessionObj as! NSData
            self.session = NSKeyedUnarchiver.unarchiveObjectWithData(sessionDataObj) as! SPTSession
            if !self.session.isValid(){
                print("invalid session")
                SPTAuth.defaultInstance().renewSession(session, callback: { (error:NSError!, session:SPTSession!) -> Void in
                    if error == nil {
                        let sessionData = NSKeyedArchiver.archivedDataWithRootObject(session)
                        userDefaults.setObject(sessionData, forKey: "SpotifySession")
                        userDefaults.synchronize()
                        self.session = session
                        self.performSegueWithIdentifier("LoggedIn", sender: self)
                    } else {
                        print("Error: \(error)")
                    }
                })
            } else {
                //valid session
                print("valid session")
                performSegueWithIdentifier("LoggedIn", sender: self)
            }
            
        } else {
            print("no session in user defaults")
            spotifyLogin.hidden = false
        }
        self.firstLoad = true
        //self.authViewController?.delegate = self
        
    }

    @IBAction func signInTapped(sender: AnyObject) {
        print("signInTapped")
        //openLoginPage()
        let auth = SPTAuth.defaultInstance()
        
        auth.clientID = CLIENT_ID
        auth.redirectURL = NSURL(string:CALLBACK_URL)
        auth.tokenRefreshURL = NSURL(string:TOKEN_REFRESH_SERVICE_URL)
        auth.tokenSwapURL = NSURL(string:TOKEN_SWAP_URL)
        auth.sessionUserDefaultsKey = SESSION_USER_DEFAULTS_KEY
        auth.requestedScopes = [SPTAuthStreamingScope] //possibily change the request scope since we aren't streaming in our application
        
        UIApplication.sharedApplication().openURL(auth.loginURL)
    }
    
}
