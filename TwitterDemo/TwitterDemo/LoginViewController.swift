//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 9/30/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "uHui9q0sDY9DL7p97iO6FY8Kk", consumerSecret: "xqCd7AY9s2IyXb4kHCkk2Yiv5ctyOqaIXUibU6gZjrZQMiigQ1")
        
        // Clear previous sessions
        twitterClient?.deauthorize()
        
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token",
                                         method: "GET",
                                         callbackURL: URL(string: "twitterdemo://oauth"),
                                         scope: nil,
                                         success: { (requestToken : BDBOAuth1Credential?) in
                                            print("Twitter secure token received")
                                            
                                            // Send the user to be authorized directly
                                            if let requestToken = requestToken {
                                                let token = requestToken.token!
                                                let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                            }},
                                         
                                         failure: { (error : Error?) in
                                            print("error : \(String(describing: error?.localizedDescription))")})
        
        
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
