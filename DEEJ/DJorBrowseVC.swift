//
//  DJorBrowseVC.swift
//  DEEJ
//
//  Created by Killian Jackson on 4/30/16.
//  Copyright © 2016 Killian Jackson. All rights reserved.
//

import UIKit

class DJorBrowseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func DJTapped(sender: AnyObject) {
        performSegueWithIdentifier("DJSelected", sender: self)
    }
    
    
    @IBAction func BrowseTapped(sender: AnyObject) {
        performSegueWithIdentifier("BrowseSelected", sender: self)
        
    }
    
    

}
