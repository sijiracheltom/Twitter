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
        let twitterClient = TwitterClient.sharedInstance
        
        twitterClient?.login(success: {
            
            TwitterClient.sharedInstance?.currentAccount(
                success: { (user: User) in
                    User.currentUser = user
            },
                failure: { (error: Error) in
                    print("Error getting current user: \(error.localizedDescription)")
            })
            
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
        }, failure: { (error: Error) -> () in
            print("Error logging in: \(String(describing: error.localizedDescription))")
        })
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
