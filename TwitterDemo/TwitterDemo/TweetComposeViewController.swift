//
//  TweetComposeViewController.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/1/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit
import MBProgressHUD

class TweetComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var tweetWordCountLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileScreenNameLabel: UILabel!
    
    var user : User!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tweetTextView.delegate = self

        // Do any additional setup after loading the view.
        self.profileNameLabel.text = user.name ?? ""
        self.profileScreenNameLabel.text = user.screenname ?? ""
        if let profileURL = user.profileURL {
            self.profileImageView.setImageWith(profileURL)
        }
        self.tweetWordCountLabel.text = "\(kTDMaxCharactersInTweet)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tweetTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tweetTextView.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let tweetStr = tweetTextView.text ?? ""
        TwitterClient.sharedInstance?.tweet(tweet: tweetStr,
                                            inReplyTo: nil,
                                            success: { [weak self] () in
                                                print("Successfully posted tweet")
                                                MBProgressHUD.hide(for: (self?.view)!, animated: true)
                                                self?.dismiss(animated: true, completion: nil)
        },
                                            failure: { [weak self] (error: Error) in
                                                print("Error posting tweet: \(error.localizedDescription)")
                                                MBProgressHUD.hide(for: (self?.view)!, animated: true)
                                                
                                                let alertController = UIAlertController(title: "Error", message: "Please try posting again", preferredStyle: UIAlertControllerStyle.alert)
                                                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                                                alertController.addAction(action)
                                                
                                                self?.present(alertController, animated: true, completion: nil)
                                                
        })
    }

    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let onScreenCharacterCount = (textView.text?.characters.count) ?? 0
        var newCharactersCount = (text.characters.count)
        if newCharactersCount == 0 {
            // characters are deleted
            newCharactersCount = range.length
        }
        let totalCharacterCount = onScreenCharacterCount + newCharactersCount
        let remainingAllowedCharacterCount = kTDMaxCharactersInTweet - totalCharacterCount
        
        if totalCharacterCount > kTDMaxCharactersInTweet {
            
            return false
        } else {
            tweetWordCountLabel.text = "\(remainingAllowedCharacterCount)"
            tweetWordCountLabel.sizeToFit()
            
            return true
        }
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
