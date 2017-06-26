//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Howard Wang on 6/26/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 6
        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else { return }
            print("Created new user: \(user.username)")
        }
    }
    
}
