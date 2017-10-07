//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 9/30/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var menuTableView: UITableView!
    
    var refreshControl : UIRefreshControl!
    var tweets = [Tweet]()
    var mainTableViewOriginialCenter : CGPoint!
    var mainTableViewCenterWhenMoved: CGPoint!
    var mainTableViewCenterWhenNotMoved: CGPoint!
    var menuTableViewDataSource : MenuTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBarHeight = navigationController?.navigationBar.bounds.height ?? 0
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let bounds = UIScreen.main.bounds
        let size = CGSize(width: bounds.size.width, height: bounds.size.height - navigationBarHeight - statusBarHeight)
        let point = CGPoint(x: 0.0, y: navigationBarHeight)
        let tableFrame = CGRect(origin: point, size: size)
        let viewFrame = CGRect(origin: CGPoint.zero, size: bounds.size)

        self.view = UIView(frame: viewFrame)
        tableView.frame = tableFrame
        menuTableView.frame = tableFrame
        
        self.view.addSubview(tableView)
        self.view.addSubview(menuTableView)
        self.view.bringSubview(toFront: tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Add pan gesture recognizer to the tableview
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(TweetsViewController.onUserPan))
        panGR.delegate = self
        tableView.addGestureRecognizer(panGR)
        
        // Initialize center points
        mainTableViewCenterWhenNotMoved = tableView.center
        mainTableViewCenterWhenMoved = tableView.center
        mainTableViewCenterWhenMoved.x += 200
        
        // Initialize menu view
        menuTableViewDataSource = MenuTableViewDataSource()
        menuTableView.delegate = menuTableViewDataSource
        menuTableView.dataSource = menuTableViewDataSource
        menuTableView.estimatedRowHeight = 200
        menuTableView.rowHeight = tableFrame.height/4
        
        // Initialize a UIRefreshControl
        self.refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        
        navigationController?.navigationBar.barStyle = UIBarStyle.blackOpaque
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 157/255.0, blue: 246/255.0, alpha: 1.0)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func onUserPan(panGestureRecognizer: UIPanGestureRecognizer) -> Void {
        print("pan detected from sender %@", panGestureRecognizer)
        
        let point = panGestureRecognizer.location(in: self.view)
        let velocity = panGestureRecognizer.velocity(in: self.view)
        
        if panGestureRecognizer.state == .began {
            mainTableViewOriginialCenter = tableView.center
            
            print("Gesture began at: \(point)")
        } else if panGestureRecognizer.state == .changed {
            
            if velocity.x > 0 {
                
                // Only scroll right
                
                let translation = panGestureRecognizer.translation(in: self.view)
                tableView.center = CGPoint(x: mainTableViewOriginialCenter.x + translation.x, y: mainTableViewOriginialCenter.y)
            }
            
            print("Gesture changed at: \(point)")
        } else if panGestureRecognizer.state == .ended {
            
            // moving right
            if velocity.x > 0 {
                UIView.animate(withDuration: 0.2,
                               delay: 0,
                               usingSpringWithDamping: 1.0,
                               initialSpringVelocity: 0,
                               options: .curveEaseInOut,
                               animations: {
                                self.tableView.center = self.mainTableViewCenterWhenMoved
                },
                               completion: nil)
            } else {
                // moving left
                UIView.animate(withDuration: 0.2,
                               delay: 0,
                               usingSpringWithDamping: 1.0,
                               initialSpringVelocity: 0,
                               options: .curveEaseInOut,
                               animations: {
                                self.tableView.center = self.mainTableViewCenterWhenNotMoved
                })
            }
            
            print("Gesture ended at: \(point)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchTweets()
    }
    
    func fetchTweets() -> Void {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
        }, failure: { (error: Error) in
            print("Error: \(error)")
            self.refreshControl.endRefreshing()
        })
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

    @IBAction func onSignOut(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }

    @IBAction func onComposeTweet(_ sender: Any) {
        self.performSegue(withIdentifier: "TweetComposeSegueID", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let nextC = segue.destination
        
        if nextC is UINavigationController {
            let composeVC = (nextC as! UINavigationController).topViewController as! TweetComposeViewController
            composeVC.user = User.currentUser
        } else if nextC is TweetDetailViewController {
            let tweetCell = sender as! TweetCell
            let indexpath = self.tableView.indexPath(for: tweetCell)!
            let tweet = self.tweets[indexpath.row] as Tweet
            
            (nextC as! TweetDetailViewController).tweet = tweet
        }        
    }
    

}
