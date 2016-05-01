//
//  PlayerViewController.swift
//  DEEJ
//
//  Created by Killian Jackson on 4/30/16.
//  Copyright © 2016 Killian Jackson. All rights reserved.
//

import UIKit
import Alamofire

class PlayerViewController: UIViewController {

    @IBOutlet weak var streamerProfilePic: UIImageView!
    var player:SPTAudioStreamingController?
    var trackMetaData: NSDictionary?
    var username: String!
    
    
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
            self.username = session.canonicalUsername
            print(self.username)
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
    
    @IBAction func playDatShit(sender: AnyObject) {
        self.player?.playURI(NSURL(string: "spotify:track:58s6EuEYJdlb0kO7awm3Vp"), callback: { (error: NSError!) in
            self.trackMetaData = (self.player?.currentTrackMetadata)!
            
            /*
            Alamofire.request(.GET, "\(SERVER_URL)/users") .validate(contentType: ["application/json"]).responseJSON { response in
                let result = response.result
                print(result)
                //let temp = result.value
                
                if let dictArray = response.result.value as? [[String: AnyObject]], let dict = dictArray.first {
                    print(dict)
                    if let client = dict["clientID"] as? String {
                        //print()
                    }
                }
            }*/
            
            Alamofire.request(.PUT, "\(SERVER_URL)/users", parameters: ["foo": "bar", "parm2": "hi"])
                .response { (request, response, data, error) in
                    print(request)
                    print(response)
                    print(error)
            }
            
            
            
        })
    }
    
    /*func fetchAllRooms(completion: ([RemoteRoom]?) -> Void) {
        Alamofire.request(
        .GET,
        "http://localhost:5984/rooms/_all_docs",
        parameters: ["include_docs": "true"],
        encoding: .URL)
        .validate()
        .responseJSON { (response) -> Void in
        guard response.result.isSuccess else {
        print("Error while fetching remote rooms: \(response.result.error)")
        completion(nil)
        return
        }
        
        guard let value = response.result.value as? [String: AnyObject],
        rows = value["rows"] as? [[String: AnyObject]] else {
        print("Malformed data received from fetchAllRooms service")
        completion(nil)
        return
        }
        
        var rooms = [RemoteRoom]()
        for roomDict in rows {
        rooms.append(RemoteRoom(jsonData: roomDict))
        }
        
        completion(rooms)
        }
    }*/

}
