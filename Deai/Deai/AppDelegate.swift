//
//  AppDelegate.swift
//  Deai
//
//  Created by Owner on 2020/06/17.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit
import NCMB
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NCMB.setApplicationKey("4ed78811aa124b52dde09f6c1d5fba1d1fc8be26a9ef88b728795905336c4b13", clientKey: "79a98bd19f2c52cb1e8f952338224b70fa1a20d7fe793f4b282439c94a80d672")
        FBSDKCoreKit.ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKCoreKit.AppEvents.activateApp()
    }
    
    func application(_ application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKCoreKit.ApplicationDelegate.shared.application(application, open: url as URL, sourceApplication: sourceApplication, annotation: annotation)
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

