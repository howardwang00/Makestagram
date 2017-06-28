//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Howard Wang on 6/28/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import UIKit

class PostActionCell: UITableViewCell {
    static let height: CGFloat = 46
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        print("like button tapped")
    }
}

