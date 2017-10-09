//
//  ProfileHeaderCell.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/8/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var user : User! {
        didSet {
            if let profileURL = user.profileURL {
                profileImageView.setImageWith(profileURL)
            }
            userNameLabel.text = user.name ?? ""
            screenNameLabel.text = "@\(user.screenname ?? "")"
            descriptionLabel.text = user.tagline ?? ""
            if let headerURL = user.headerImageURL {
                headerImageView.setImageWith(headerURL)
            } else if let backgroundURL = user.headerBackgroundURL {
                headerImageView.setImageWith(backgroundURL)
            }
            followingCountLabel.text = String(user.following)
            followersCountLabel.text = String(user.followers)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
