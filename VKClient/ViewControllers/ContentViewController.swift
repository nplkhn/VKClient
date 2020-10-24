//
//  ContentViewController.swift
//  VKClient
//
//  Created by Никита Плахин on 10/22/20.
//

import UIKit

class ContentViewController: UITabBarController {
    
    private var feedVC: FeedTableViewController = {
        let vc = FeedTableViewController()
        let tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        vc.tabBarItem = tabBarItem
        return vc
    }()
    private var profileVC: ProfileViewController = {
        let vc = ProfileViewController()
        let tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        vc.tabBarItem = tabBarItem
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [feedVC, profileVC]
        tabBar.tintColor = UIColor(named: "vkBlue")
//        tabBar.tintColor = .white
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
