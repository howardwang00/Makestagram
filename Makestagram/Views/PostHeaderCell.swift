//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Howard Wang on 6/28/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    static let height: CGFloat = 54
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func optionsButtonTapped(_ sender: Any) {
        print("options button tapped")
    }
}


