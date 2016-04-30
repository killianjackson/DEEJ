//
//  StreamCell.swift
//  DEEJ
//
//  Created by Killian Jackson on 4/30/16.
//  Copyright © 2016 Killian Jackson. All rights reserved.
//

import UIKit

class StreamCell: UITableViewCell {

    @IBOutlet weak var streamerImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var currentTrack: UILabel!
    
    var stream: Stream!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func drawRect(rect: CGRect) {
        streamerImg.layer.cornerRadius = streamerImg.frame.size.width / 2
        streamerImg.clipsToBounds = true
        streamerImg.clipsToBounds = true
    }
    
    func configureCell (stream: Stream) {
        self.stream = stream
        self.username.text = stream.username
        self.currentTrack.text = "Now playing: \(stream.currentTrack)"
    }

}
