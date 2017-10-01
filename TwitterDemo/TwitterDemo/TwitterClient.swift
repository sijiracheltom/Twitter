//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 9/30/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "uHui9q0sDY9DL7p97iO6FY8Kk", consumerSecret: "xqCd7AY9s2IyXb4kHCkk2Yiv5ctyOqaIXUibU6gZjrZQMiigQ1")
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json",
            parameters: nil,
            progress: nil,
            success: { (task: URLSessionDataTask, response: Any?) in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                
                success(tweets)
        },
            
            failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        })
    }
    
    func updateCurrentUser() {
        currentAccount(
            success: { (user: User) in
                User.currentUser = user
        },
            failure: { (error: Error) in
                print("Error getting current user: \(error.localizedDescription)")
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json",
            parameters: nil,
            progress: nil,
            
            success: {(task : URLSessionDataTask, response: Any?) in
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)

                success(user)
            },
            
            failure: { (task: URLSessionDataTask?, error: Error) in
                failure (error)
            }
        )
    }
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) -> () {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        
        fetchRequestToken(withPath: "oauth/request_token",
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
                            self.loginFailure?(error!)}
        )
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kTDUserDidSignOutNotificationName), object: nil)
    }
    
    func handleOpenURL(url : URL) -> () {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token",
                         method: "POST",
                         requestToken: requestToken,
                         success: { (accessToken : BDBOAuth1Credential?) in
                            print("Sucessful! Access token: \(accessToken!.token)")
                            self.loginSuccess?()
                        },
                         
                         failure: { (error: Error?) in
                            print("Error: \(error!.localizedDescription)")
                            self.loginFailure?(error!)
                        }
        )
    }
}
