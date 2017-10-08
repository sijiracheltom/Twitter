//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/8/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var tweets = [Tweet]()
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        tableView.tableFooterView = UIView()
        
        if let backgroundColor = user.headerBackgroundColor {
            tableView.backgroundColor = backgroundColor
        }
        
        fetchUserTimeLine(forUserID: user.id)
    }
    
    func fetchUserTimeLine(forUserID: Int!) -> Void {
        TwitterClient.sharedInstance?.userTimeline(_userID: forUserID, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print("Error fetching user timeline: \(error)")
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        
        if indexPath.row == 0 {
            // cell 1 is profile cell
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderCell", for: indexPath)
            let profileCell = cell as! ProfileHeaderCell
            profileCell.user = user
        } else {
            // all others are tweet cells
            cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath)
            let tweet = tweets[indexPath.row - 1]
            
            let tweetCell = cell as! TweetTableViewCell
            tweetCell.tweet = tweet
        }
        
        return cell        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TweetTableViewCell
        performSegue(withIdentifier: "ProfileToDetailSegueID", sender: cell)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let nextC = segue.destination
        if nextC is TweetDetailViewController {
            let tweetCell = sender as! TweetTableViewCell
            let indexpath = self.tableView.indexPath(for: tweetCell)!
            let tweet = self.tweets[indexpath.row - 1] as Tweet
            
            (nextC as! TweetDetailViewController).tweet = tweet
        }
    }

}
