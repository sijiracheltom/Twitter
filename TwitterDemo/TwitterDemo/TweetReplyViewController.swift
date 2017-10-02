//
//  TweetReplyViewController.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/1/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class TweetReplyViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var userName: String!
    var statusID: Int!
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPost(_ sender: Any) {
        let tweetStr = textView.text
        TwitterClient.sharedInstance?.tweet(tweet: tweetStr, inReplyTo: statusID, success: nil, failure: { (error: Error) in
            print("Error replying: \(error.localizedDescription)")
        })
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.contentOffset = CGPoint.zero
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = "@\(userName!)"
        
        navigationController?.navigationBar.barStyle = UIBarStyle.blackOpaque
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 157/255.0, blue: 246/255.0, alpha: 1.0)
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
