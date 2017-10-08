//
//  Utilities.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/1/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

public let kTDUserDidSignOutNotificationName = "UserDidSignOut"
public let kTDMaxCharactersInTweet : Int = 140

public enum MenuOptions : Int {
    case profile = 0
    case timeLine
    case mentions
    case totalCount
}

public func stringify(menuOption : MenuOptions) -> String! {
    var str = ""
    
    switch menuOption {
    case .profile:
        str = "Profile"
    case .timeLine:
        str = "Home"
    case .mentions:
        str = "Mentions"
    case .totalCount:
        str = ""
    }
    
    return str
}
