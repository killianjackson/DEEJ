//
//  ViewController.swift
//  DEEJ
//
//  Created by Killian Jackson on 4/29/16.
//  Copyright © 2016 Killian Jackson. All rights reserved.
//

import UIKit

class StreamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var streamTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var streams = [Stream]()
    var filteredStreams = [Stream]()
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streamTableView.delegate = self
        streamTableView.dataSource = self
        searchBar.delegate = self
        
        let stream1 = Stream(username: "killianjackson", currentTrack: "Back to back by Drake")
        let stream2 = Stream(username: "jewfrorabbi", currentTrack: "gypsy music")
        let stream3 = Stream(username: "jakeromanas", currentTrack: "Shake that monkey by Too$hort")
        let stream4 = Stream(username: "joeygomezbenito", currentTrack: "Snow by Red Hot Chili Peppers")
        
        streams.append(stream1)
        streams.append(stream2)
        streams.append(stream3)
        streams.append(stream4)
        
        streamTableView.reloadData()
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (inSearchMode) {
            return filteredStreams.count
        } else {
            return streams.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("StreamCell") as? StreamCell {
            let stream : Stream!
            if(inSearchMode) {
                stream = filteredStreams[indexPath.row]
            } else {
                stream = streams[indexPath.row]
            }
            cell.configureCell(stream)
            return cell
        } else {
            return StreamCell()
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let stream = streams[indexPath.row]
        performSegueWithIdentifier("MusicPlayerSegue", sender: stream)
        self.streamTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            streamTableView.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredStreams = streams.filter({$0.username.lowercaseString.rangeOfString(lower) != nil})
        }
        streamTableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MusicPlayerSegue" {
            let playerViewController = segue.destinationViewController as! PlayerViewController
        }
    }

}

