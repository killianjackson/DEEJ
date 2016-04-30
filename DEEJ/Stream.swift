//
//  Stream.swift
//  DEEJ
//
//  Created by Killian Jackson on 4/29/16.
//  Copyright © 2016 Killian Jackson. All rights reserved.
//

class Stream {
    private var _username: String!
    private var _currentTrack: String!
    
    var username: String {
        return _username
    }
    
    var currentTrack: String {
        return _currentTrack
    }
    
    init(username: String, currentTrack: String) {
        self._username = username
        self._currentTrack = currentTrack
    }
}
