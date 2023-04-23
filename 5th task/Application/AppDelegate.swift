//
//  AppDelegate.swift
//  5th task
//
//  Created by Владимир Курганов on 31.10.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let router = MainRouter()
        window?.rootViewController = router.initialView()
        window?.makeKeyAndVisible()
        return true
    }
}

