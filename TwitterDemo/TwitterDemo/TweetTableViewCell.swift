//
//  TweetTableViewCell.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/8/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var twitterHandle: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            self.tweetText.text = tweet.text
            self.nameLabel.text = tweet.user?.name
            self.twitterHandle.text = "@\(tweet.user?.screenname ?? "")"
            
            if let url = tweet.user?.profileURL {
                self.profileImage.setImageWith(url)
            }
            
            if let creationDate = tweet.creationDate {
                let componentSet : Set = [Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second]
                let components = Calendar.current.dateComponents(componentSet,
                                                                 from: creationDate,
                                                                 to: Date())
                self.timestampLabel.text = timeString(components: components)
            }
        }
    }
    
    func timeString(components : DateComponents) -> String! {
        var timeStr = ""
        
        let h = components.hour!
        let m = components.minute!
        let s = components.second!
        if h != 0 {
            timeStr = "\(h)h"
        } else if m != 0 {
            timeStr = "\(m)m"
        } else {
            timeStr = "\(s)s"
        }
        
        return timeStr
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.profileImage.layer.cornerRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
