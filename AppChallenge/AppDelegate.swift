//
//  AppDelegate.swift
//  Assignment
//
//  Created by Nitin on 22/06/22.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var isReachable = true
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupReachability()
        return true
    }
    
    private func setupReachability() {
        
        // Allocate a reachability object
        let reach = Reachability.forInternetConnection()
        self.isReachable = reach!.isReachable()
        
        // Set the blocks
        reach?.reachableBlock = { (reachability) in
            
            DispatchQueue.main.async(execute: {
                self.isReachable = true
            })
        }
        reach?.unreachableBlock = { (reachability) in
            DispatchQueue.main.async(execute: {
                self.isReachable = false
            })
        }
        reach?.startNotifier()
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

