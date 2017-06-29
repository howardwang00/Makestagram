//
//  Post.swift
//  Makestagram
//
//  Created by Howard Wang on 6/27/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    var key: String?
    let imageURL: String
    let imageHeight: CGFloat
    let creationDate: Date
    
    var likeCount: Int
    let poster: User
    
    var isLiked = false
    
    init(imageURL: String, imageHeight: CGFloat) {
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.creationDate = Date()
        
        self.likeCount = 0
        self.poster = User.current
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let imageURL = dict[Constants.Post.image_url] as? String,
            let imageHeight = dict[Constants.Post.image_height] as? CGFloat,
            let createdAgo = dict[Constants.Post.created_at] as? TimeInterval,
            let likeCount = dict[Constants.Post.like_count] as? Int,
            let userDict = dict[Constants.Post.poster] as? [String : Any],
            let uid = userDict[Constants.Post.uid] as? String,
            let username = userDict[Constants.Post.username] as? String
            else { return nil }
        
        self.key = snapshot.key
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.creationDate = Date(timeIntervalSince1970: createdAgo)
        
        self.likeCount = likeCount
        self.poster = User(uid: uid, username: username)
    }
    
    var dictValue: [String : Any] {
        let createdAgo = creationDate.timeIntervalSince1970
        let userDict = [Constants.Post.uid : poster.uid,
                        Constants.Post.username : poster.username]
        
        return [Constants.Post.image_url : imageURL,
                Constants.Post.image_height : imageHeight,
                Constants.Post.created_at : createdAgo,
                Constants.Post.like_count : likeCount,
                Constants.Post.poster : userDict]
    }
}
