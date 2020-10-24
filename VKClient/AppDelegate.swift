//
//  AppDelegate.swift
//  VKClient
//
//  Created by Никита Плахин on 10/21/20.
//

import UIKit
import VK_ios_sdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {
    
    var window: UIWindow?
    var authService: AuthService!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.authService = AuthService()
//        authService.delegate = 
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        
        authService.wakeUpSession()
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        VKSdk.processOpen(url, fromApplication: sourceApplication)
        return true
    }
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // MARK: - Auth service delegate
    func authServiceShouldShow(_ viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
        window?.makeKeyAndVisible()
    }
    
    func authServiceSignIn() {
        let contentVC = ContentViewController()
        let navVC = UINavigationController(rootViewController: contentVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    func authServiceDidSignInFail() {
        let loginVC = LoginViewController()
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
    }
}

