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
        case .counter:
            cell = tableView.dequeueReusableCell(withIdentifier: "CounterCell", for: indexPath)
        case .controls:
            cell = tableView.dequeueReusableCell(withIdentifier: "ControlsCell", for: indexPath)
        case .totalCount:
            break
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}