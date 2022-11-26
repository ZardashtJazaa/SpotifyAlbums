//
//  AppDelegate.swift
//  SpotifyAlbums
//
//  Created by Zardasht on 11/26/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
//        let navigationController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = ViewController()
        
        return true
        
        
    }

}

