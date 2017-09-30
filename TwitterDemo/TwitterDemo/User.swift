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
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        if let url = dictionary["profile_image_url_https"] as? String {
            profileURL = URL(string: url)
        }
        tagline = dictionary["description"] as? String
    }
}
