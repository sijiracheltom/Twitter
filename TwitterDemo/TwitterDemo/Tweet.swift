//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 9/30/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var creationDate: Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var id: Int = 0
    var user: User?
    var isRetweeted: Bool = false
    var isFavorited: Bool = false
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favourites_count"] as? Int) ?? 0
        id = (dictionary["id"] as? Int) ?? 0
        isRetweeted = (dictionary["retweeted"] as? Bool) ?? false
        isFavorited = (dictionary["favorited"] as? Bool) ?? false
        
        let timestampString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        if let timestampString = timestampString {
            creationDate = formatter.date(from: timestampString)
        }
        
        let userDict = dictionary["user"] as! NSDictionary
        user = User(dictionary: userDict)
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dict in dictionaries {
            let tweet = Tweet(dictionary: dict)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
