//
//  FindFriendsCell.swift
//  Makestagram
//
//  Created by Howard Wang on 6/29/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import UIKit

class FindFriendsCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.layer.borderColor = UIColor.lightGray.cgColor
        followButton.layer.borderWidth = 1
        followButton.layer.cornerRadius = 6
        followButton.clipsToBounds = true
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitle("Following", for: .selected)
    }
    @IBAction func followButtonTapped(_ sender: UIButton) {
        print("follow button tapped")
    }
}
