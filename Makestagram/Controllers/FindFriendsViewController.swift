//
//  FindFriendsViewController.swift
//  Makestagram
//
//  Created by Howard Wang on 6/26/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import UIKit

class FindFriendsViewController: UIViewController {
    var users = [User]()
    @IBOutlet weak var findFriendsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findFriendsTableView.tableFooterView = UIView()
        findFriendsTableView.rowHeight = 71
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserService.usersExcludingCurrentUser { [unowned self] (users) in
            self.users = users
            DispatchQueue.main.async {
                self.findFriendsTableView.reloadData()
            }
        }
    }
}

extension FindFriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FindFriends.findFriendsCell) as! FindFriendsCell
        cell.delegate = self
        configure(cell: cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configure(cell: FindFriendsCell, atIndexPath indexPath: IndexPath) {
        let user = users[indexPath.row]
        cell.usernameLabel.text = user.username
        cell.followButton.isSelected = user.isFollowed
    }
}

extension FindFriendsViewController: FindFriendsCellDelegate {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFriendsCell) {
        guard let indexPath = findFriendsTableView.indexPath(for: cell) else { return }
        
        followButton.isUserInteractionEnabled = false
        let followee = users[indexPath.row]
        FollowService.setIsFollowing(!followee.isFollowed, fromCurrentUserTo: followee) { (success) in
            defer {
                followButton.isUserInteractionEnabled = true
            }
            
            guard success else { return }
            followee.isFollowed = !followee.isFollowed
            self.findFriendsTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}


