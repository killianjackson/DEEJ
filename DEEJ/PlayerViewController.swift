//
//  PlayerViewController.swift
//  DEEJ
//
//  Created by Killian Jackson on 4/30/16.
//  Copyright © 2016 Killian Jackson. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var streamerProfilePic: UIImageView!
    var player:SPTAudioStreamingController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streamerProfilePic.layer.cornerRadius = streamerProfilePic.frame.size.width / 2
        streamerProfilePic.clipsToBounds = true
        streamerProfilePic.clipsToBounds = true
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let sessionObj = userDefaults.objectForKey("SpotifySession") {
            let sessionDataObj = sessionObj as! NSData
            let session = NSKeyedUnarchiver.unarchiveObjectWithData(sessionDataObj) as! SPTSession
            playUsingSession(session)
        }
    }

    
    func playUsingSession(sessionObj: SPTSession!){
        if player == nil {
            player = SPTAudioStreamingController(clientId: CLIENT_ID)
        }
        player?.loginWithSession(sessionObj, callback: { (error:NSError!) -> Void in
            if error != nil {
                print("error: \(error)")
                return
            }
            
            //SPTTrack.trackWithURI("spotify:track:58s6EuEYJdlb0kO7awm3Vp", session: sessionObj, callback: {(error: NSError!, album: AnyObject!) -> Void})
            SPTTrack.trackWithURI(NSURL(string: "spotify:track:58s6EuEYJdlb0kO7awm3Vp"), session: sessionObj, callback: { (error: NSError!, track: AnyObject!) in
                print(track)
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func hideBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
