//
//  RetweetFavoriteCell.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/1/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class RetweetFavoriteCell: UITableViewCell {

    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            self.retweetLabel.text = "\(tweet.retweetCount)"
            self.favoriteLabel.text = "\(tweet.favoriteCount)"
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
