//
//  TweetDetailViewController.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/1/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweet: Tweet!
    @IBOutlet weak var tableView: UITableView!

    enum TableViewRows: Int {
        case tweetDetail = 0
        case counter
        case controls
        case totalCount
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10.0))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewRows.totalCount.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = TableViewRows(rawValue: indexPath.row)!
        
        var cell = UITableViewCell()
        
        switch row {
        case .tweetDetail:
            cell = tableView.dequeueReusableCell(withIdentifier: "TweetDetailCell", for: indexPath)
            (cell as! DetailTweetCell).tweet = self.tweet
            
        case .counter:
            cell = tableView.dequeueReusableCell(withIdentifier: "CounterCell", for: indexPath)
            (cell as! RetweetFavoriteCell).tweet = self.tweet
            
        case .controls:
            cell = tableView.dequeueReusableCell(withIdentifier: "ControlsCell", for: indexPath)
            (cell as! ControlsCell).tweet = self.tweet
            
        case .totalCount:
            break
        }
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nextC = segue.destination
        if nextC is UINavigationController {
            let replyVC = (nextC as! UINavigationController).topViewController as! TweetReplyViewController
            replyVC.userName = tweet.user?.screenname ?? ""
            replyVC.statusID = tweet.id
        }
        else if nextC is ProfileViewController {
            if sender is UITapGestureRecognizer {
                (nextC as! ProfileViewController).user = tweet.user
            }
        }
    }
    
}
