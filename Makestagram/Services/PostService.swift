//
//  PostService.swift
//  Makestagram
//
//  Created by Howard Wang on 6/27/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    static func create(for image: UIImage) {
        let imageRef = StorageReference.newPostImageReference()
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            create(forURLString: urlString, aspectHeight: aspectHeight)
        }
    }
    
    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
        let currentUser = User.current
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        
        let rootRef = Database.database().reference()
        let newPostRef = rootRef.child(Constants.posts).child(currentUser.uid).childByAutoId()
        let newPostKey = newPostRef.key
        
        UserService.followers(for: currentUser) { (followerUIDs) in
            let timelinePostDict = [Constants.Follow.posterUID : currentUser.uid]
            var updatedData: [String : Any] = ["\(Constants.timeline)/\(currentUser.uid)/\(newPostKey)" : timelinePostDict]
            
            for uid in followerUIDs {
                updatedData["\(Constants.timeline)/\(uid)/\(newPostKey)"] = timelinePostDict
            }
            let postDict = post.dictValue
            updatedData["\(Constants.posts)/\(currentUser.uid)/\(newPostKey)"] = postDict
            
            rootRef.updateChildValues(updatedData)
        }
    }
    
    public static func show(forKey postKey: String, posterUID: String, completion: @escaping (Post?) -> Void) {
        let postRef = Database.database().reference().child(Constants.posts).child(posterUID).child(postKey)
        postRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let post = Post(snapshot: snapshot) else {
                return completion(nil)
            }
            LikeService.isPostLiked(post) { (isLiked) in
                post.isLiked = isLiked
                completion(post)
            }
        })
    }
    
}
