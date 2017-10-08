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
    case timeLine = 0
    case profile
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

public func UIColorFromRGB(rgbStr : String!) -> (UIColor?) {
//    let rgbValue = rgbStr.data(using: String.Encoding.utf8)
    var rgbValue : UInt32 = 0
    guard Scanner(string: rgbStr).scanHexInt32(&rgbValue) else { return nil}
    
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0,
                   green: ((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0,
                   blue: ((CGFloat)(rgbValue & 0xFF))/255.0,
                   alpha:1.0)
}
