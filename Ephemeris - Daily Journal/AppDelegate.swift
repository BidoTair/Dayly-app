//
//  AppDelegate.swift
//  Ephemeris - Daily Journal
//
//  Created by Abdulghafar Al Tair on 6/20/16.
//  Copyright © 2016 Abdulghafar Al Tair. All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var landingscreenNavigationController: UINavigationController?
    var mainscreenNavigationController: UINavigationController?

    //  AppDelegate.m
    
//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
//        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//        // Add any custom logic here.
//        return true
//    }
    
//    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String, annotation: AnyObject) -> Bool {
//        var handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
//        // Add any custom logic here.
//        return handled
//    }
    
        
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        let lvc = LandingScreenViewController(nibName: "LandingScreenViewController", bundle: nil)
        landingscreenNavigationController = UINavigationController(rootViewController: lvc)
        
//        let mvc = MainScreenViewController(nibName: "MainScreenViewController", bundle: nil)
//       mainscreenNavigationController = UINavigationController(rootViewController: mvc)
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = landingscreenNavigationController
        self.window?.makeKeyAndVisible()
        
        
        
        
        return true
    }
    
    func navigateToMainScreen() {
        let mvc = MainScreenViewController(nibName: "MainScreenViewController", bundle: nil)
        mainscreenNavigationController = UINavigationController(rootViewController: mvc)
        self.window?.rootViewController = mainscreenNavigationController
    }
    
    func navigateToLandingScreen() {
        self.window?.rootViewController = landingscreenNavigationController
        let lvcafterlogin = LandingScreenViewController(nibName: "LandingScreenViewController", bundle: nil)
        let landingscreenafterloginnavController = UINavigationController(rootViewController: lvcafterlogin)
        lvcafterlogin.loginBool = false
        PersistenceManager.saveObject(lvcafterlogin.loginBool, fileName: "loginBool")
        self.window?.rootViewController = landingscreenafterloginnavController
        
    }
    
        func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
            var handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
            // Add any custom logic here.
            return handled
        }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
            FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

