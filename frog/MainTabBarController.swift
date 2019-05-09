//
//  MainTabBarController.swift
//  frog
//
//  Created by Lili on 24/04/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import UIKit
class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        tabBar.tintColor = .purple
        
        setupViewControllers()
        setupPlayerDetailsView()
        
    }
    //MARK: - Setup Func
    
     fileprivate func setupPlayerDetailsView(){
            print("Setting up PlayerDetailsView")
        
        let playerDetailsView = PlayerDetailsView.initFromNib()
        playerDetailsView.backgroundColor = .red
     //   playerDetailsView.frame = view.frame
        
        // use auto layout
        view.addSubview(playerDetailsView)
        //enable auto layout
        playerDetailsView.translatesAutoresizingMaskIntoConstraints = false
        //playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64).isActive = true
        playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
    
    }
    
    func setupViewControllers(){
    viewControllers = [
    generateNavigationController(for: PodcastsSearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
    generateNavigationController(for: ViewController(), title: "Favorites", image: #imageLiteral(resourceName: "favorites")),
    generateNavigationController(for: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
    
    ]
         }
    
    //MARK: Helper Func
    
    
    fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        //navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    
    
}
