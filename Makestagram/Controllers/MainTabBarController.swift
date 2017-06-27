//
//  MainTabBarViewController.swift
//  Makestagram
//
//  Created by Howard Wang on 6/27/17.
//  Copyright © 2017 Howard Wang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    let photoHelper = MGPhotoHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoHelper.completionHandler = { image in
            PostService.create(for: image)
        }
        
        delegate = self
        tabBar.unselectedItemTintColor = .black
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            photoHelper.presentActionSheet(from: self)
            return false
        } else {
            return true
        }
        
    }
}
