//
//  User.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 9/30/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit


class User: NSObject {
    var name : String?
    var screenname: String?
    var profileURL: URL?
    var tagline: String?
    var dictionary: NSDictionary?
    var followers : Int!
    var following : Int!
    var headerImageURL : URL?
    var headerBackgroundColor: UIColor?
    var id : Int!
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        if let url = dictionary["profile_image_url_https"] as? String {
            profileURL = URL(string: url)
        }
        tagline = dictionary["description"] as? String
        followers = (dictionary["followers_count"] as? Int) ?? 0
        following = (dictionary["friends_count"] as? Int) ?? 0
        if let headerURL = dictionary["profile_background_image_url_https"] as? String {
            headerImageURL = URL(string: headerURL)
        }
        if let profileBackgroundColorStr = dictionary["profile_background_color"] as? String {
            if let headerColor = UIColorFromRGB(rgbStr: profileBackgroundColorStr) {
                headerBackgroundColor = headerColor
            }
        }
        id = dictionary["id"] as! Int
    }        
    
    static let userDataKey = "currentUserData"
    static private var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: User.userDataKey) as? Data
                if let userData = userData {
                    do {
                        let dict = try JSONSerialization.jsonObject(with: userData, options: []) as? NSDictionary
                        if let dict = dict {
                            _currentUser = User(dictionary: dict)
                        }
                    }
                    catch {
                        print("Something went wrong. Clearing user defaults")
                        defaults.set(nil, forKey: User.userDataKey)
                    }
                }
            }
            
            return _currentUser
        }
        set(user) {
            if _currentUser != user {
                _currentUser = user
                let defaults = UserDefaults.standard
                if let user = user {
                    let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                    defaults.set(data, forKey: User.userDataKey)
                } else {
                    defaults.set(nil, forKey: User.userDataKey)
                }
                
                defaults.synchronize()
            }
        }
    }
}
