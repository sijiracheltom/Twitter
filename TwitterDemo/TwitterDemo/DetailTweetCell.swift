//
//  DetailTweetCell.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/1/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit
import AFNetworking

class DetailTweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            self.nameLabel.text = tweet.user?.name
            self.screenNameLabel.text = "@\(tweet.user?.screenname ?? "")"
            if let url = tweet.user?.profileURL {
                self.profileImageView.setImageWith(url)
            }
            
            if let creationDate = tweet.creationDate {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/YY hh:mm a"
                let dateStr = formatter.string(from: creationDate)
                self.dateTimeLabel.text = dateStr
            }
        }

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
