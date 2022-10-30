//
//  AppDelegate.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(
      frame: .init(
        x: 0,
        y: 0,
        width: UIScreen.main.bounds.width,
        height: UIScreen.main.bounds.height
      )
    )

    window?.rootViewController = ViewController()

    window?.makeKeyAndVisible()

    return true
  }
}

