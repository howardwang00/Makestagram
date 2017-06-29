//
//  Constants.swift
//  Makestagram
//
//  Created by Howard Wang on 6/26/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import Foundation

struct Constants {
    
    static let users = "users"
    static let posts = "posts"
    
    struct Segue {
        static let toCreateUsername = "toCreateUsername"
    }
    
    struct UserDefaults {
        static let currentUser = "currentUser"
        static let uid = "uid"
        static let username = "username"
    }
    
    struct Post {
        static let postHeaderCell = "PostHeaderCell"
        static let postImageCell = "PostImageCell"
        static let postActionCell = "PostActionCell"
    }
    
    struct Likes {
        
    }
}
