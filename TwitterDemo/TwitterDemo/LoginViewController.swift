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

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginButton.backgroundColor = UIColor(red: 0/255.0, green: 157/255.0, blue: 246/255.0, alpha: 1.0)
    }

    @IBAction func onLogin(_ sender: Any) {
        let twitterClient = TwitterClient.sharedInstance
        
        twitterClient?.login(success: {                        
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
