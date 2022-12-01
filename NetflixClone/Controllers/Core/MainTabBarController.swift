//
//  MainTabBarController.swift
//  NetflixClone
//
//  Created by alkalemir on 1.12.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        UINavigationBar.appearance().standardAppearance = appearance
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: HotMoviesViewController())
        let vc3 = UINavigationController(rootViewController: ReelsViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.title = "New & Hot"
        vc3.tabBarItem.title = "Fast Laughs"
        vc4.tabBarItem.title = "Downloads"
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        vc3.tabBarItem.image = UIImage(systemName: "face.smiling.inverse")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.circle")
        tabBar.tintColor = .white
        
        viewControllers = [vc1, vc2, vc3, vc4]
    }
}
