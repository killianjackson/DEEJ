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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streamerProfilePic.layer.cornerRadius = streamerProfilePic.frame.size.width / 2
        streamerProfilePic.clipsToBounds = true
        streamerProfilePic.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
