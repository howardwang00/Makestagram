//
//  FollowService.swift
//  Makestagram
//
//  Created by Howard Wang on 6/29/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct FollowService {
    private static func followUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        let currentUID = User.current.uid
        let followData = ["\(Constants.Follow.followers)/\(user.uid)/\(currentUID)" : true,
                          "\(Constants.Follow.following)/\(currentUID)/\(user.uid)" : true]
        
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            
            UserService.posts(for: user) { (posts) in
                let postKeys = posts.flatMap { $0.key }
                var followData = [String : Any]()
                let timelinePostDict = [Constants.Follow.posterUID : user.uid]
                
                postKeys.forEach { followData["\(Constants.timeline)/\(currentUID)/\($0)"] = timelinePostDict }
                
                ref.updateChildValues(followData, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                    }
                    
                    success(error == nil)
                })
            }
        }
    }
    
    private static func unfollowUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        let currentUID = User.current.uid
        let followData = ["\(Constants.Follow.followers)/\(user.uid)/\(currentUID)" : NSNull(),
                          "\(Constants.Follow.following)/\(currentUID)/\(user.uid)" : NSNull()]
        
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in   //error, ref
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            
            UserService.posts(for: user) { (posts) in
                let postKeys = posts.flatMap { $0.key }
                var followData = [String : Any]()
                
                postKeys.forEach { followData["\(Constants.timeline)/\(currentUID)/\($0)"] = NSNull() }
                
                ref.updateChildValues(followData, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                    }
                    
                    success(error == nil)
                })
            }
        }
        
    }
    
    static func setIsFollowing(_ isFollowing: Bool, fromCurrentUserTo followee: User, success: @escaping (Bool) -> Void) {
        if isFollowing {
            followUser(followee, forCurrentUserWithSuccess: success)
        } else {
            unfollowUser(followee, forCurrentUserWithSuccess: success)
        }
    }
    
    static func isUserFollowed(_ user: User, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference().child(Constants.Follow.followers).child(user.uid)
        ref.queryEqual(toValue: nil, childKey: User.current.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
}

