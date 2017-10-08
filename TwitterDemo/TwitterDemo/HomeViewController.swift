//
//  HomeViewController.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 9/30/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet var tableView: UITableView!
    
    var refreshControl : UIRefreshControl!
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension                
        
        // Initialize a UIRefreshControl
        self.refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchTweets()
    }
    
    func fetchTweets() -> Void {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            if self.tweets.count > 0 {
                self.setNoContentView(enabled: false)
            } else {
                self.setNoContentView(enabled: true)
            }
            
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
        }, failure: { (error: Error) in
            print("Error: \(error)")
            self.setNoContentView(enabled: true)
            self.refreshControl.endRefreshing()
        })
    }
    
    func setNoContentView(enabled : Bool) -> Void {
        if enabled {
            tableView.tableFooterView = tableView.dequeueReusableCell(withIdentifier: "NoContentCell");
        } else {
            tableView.tableFooterView = nil
        }
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchTweets()
    }
    
    // MARK: - tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell        
        cell.tweet = tweets[indexPath.row]
        return cell
    }    

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let nextC = segue.destination        
        if nextC is TweetDetailViewController {
            let tweetCell = sender as! TweetCell
            let indexpath = self.tableView.indexPath(for: tweetCell)!
            let tweet = self.tweets[indexpath.row] as Tweet
            
            (nextC as! TweetDetailViewController).tweet = tweet
        }
        // Profile VC
        else if nextC is ProfileViewController {
            if sender is UITapGestureRecognizer {
                
                // Which cell was tapped?
                let location = (sender as! UITapGestureRecognizer).location(in: tableView)
                let indexpath = tableView.indexPathForRow(at: location)
                let tweet = tweets[indexpath?.row ?? 0]
                
                (nextC as! ProfileViewController).user = tweet.user
            }
        }
        
    }
    

}
