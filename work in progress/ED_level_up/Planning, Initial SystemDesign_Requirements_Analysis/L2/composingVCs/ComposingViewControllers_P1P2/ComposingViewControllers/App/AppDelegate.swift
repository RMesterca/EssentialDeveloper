//
//  AppDelegate.swift
//  ComposingViewControllers
//
//  Created by Raluca Mesterca on 11/04/2020.
//  Copyright © 2020 fig. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if let views = (window?.rootViewController as? UITabBarController)?.viewControllers,
            let single = views[0] as? SinglePlayerViewController,
            let multi = views[1] as? MultiPlayerViewController,
            let timed = views[2] as? TimedMultiPlayerViewController {

            _ = single.view
            _ = multi.view
            _ = timed.view

            single.player?.name = "Test!"

            multi.players?.playerOne?.name = "Test 1"
            multi.players?.playerTwo?.name = "Test 2"

            timed.players?.playerOne?.name = "Test 3"
            timed.players?.playerTwo?.name = "Test 4"
        }

        return true
    }
}

