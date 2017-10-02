//
//  ControlsCell.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/1/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class ControlsCell: UITableViewCell {
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var _isFavorited : Bool = false {
        didSet {
            let favImage = _isFavorited ? #imageLiteral(resourceName: "favorite_filled") : #imageLiteral(resourceName: "favorite_unfilled");
            self.favoriteButton.setBackgroundImage(favImage, for: UIControlState.normal)
        }
    }
    
    var _isRetweeted: Bool = false {
        didSet {
            let retweetImage = _isRetweeted ? #imageLiteral(resourceName: "retweet_filled") : #imageLiteral(resourceName: "retweet_unfilled");
            self.retweetButton.setBackgroundImage(retweetImage, for: .normal)
        }
    }
    
    var tweet: Tweet! {
        didSet {
            _isFavorited = tweet.isFavorited
            _isRetweeted = tweet.isRetweeted
        }
    }
    
    
    @IBAction func onReply(_ sender: Any) {
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        let shouldRetweet = _isRetweeted ? false : true
        TwitterClient.sharedInstance?.retweet(tweetID: tweet.id, shouldRetweet: shouldRetweet)
        _isRetweeted = !_isRetweeted
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        let shouldFavorite = _isFavorited ? false : true
        TwitterClient.sharedInstance?.favorite(tweetID: tweet.id, shouldFavorite: shouldFavorite)
        _isFavorited = !_isFavorited
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
