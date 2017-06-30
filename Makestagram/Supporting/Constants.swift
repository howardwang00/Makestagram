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
        
        static let image_url = "image_url"
        static let image_height = "image_height"
        static let created_at = "created_at"
        
        static let like_count = "like_count"
        static let poster = "poster"
        static let uid = "uid"
        static let username = "username"
    }
    
    struct LikeService {
        static let postLikes = "postLikes"
    }
    
    struct FollowService {
        static let followers = "followers"
        static let following = "following"
    }
    
    struct FindFriends {
        static let findFriendsCell = "FindFriendsCell"
    }
}
