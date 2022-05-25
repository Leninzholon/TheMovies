//
//  CustomTabBar.swift
//  TheMovies
//
//  Created by apple on 20.05.2022.
//

import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            NotificationCenter.default.post(name: .favoriteController, object: nil, userInfo: nil)
                      
     
  
    }
}
