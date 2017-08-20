//
//  AppDelegate.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 13/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit
// import CoreData
import ChameleonFramework
// import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    Style.setupTheme()
    DataManager.shared.setup()
    
    // Replace Main.storyboard with code
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
    window?.rootViewController = UINavigationController(rootViewController: TracksViewController())
    
    let adMobID = "ca-app-pub-4605466962808569~2812542748"
    GADMobileAds.configure(withApplicationID: adMobID)
    
    // FirebaseApp.configure()
    
    return true
  }
  
}

