//
//  AppDelegate.swift
//  Mooskine
//
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let dataController = DataController(modelName: "Mooskine")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        dataController.load { /* update the main UI */ }

        injectDataController()

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        dataController.savedIfNeeded()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        dataController.savedIfNeeded()
    }
}

extension AppDelegate {

    func injectDataController() {
        guard let navigationController = window?.rootViewController as? UINavigationController
            else { return assertionFailure() }
        guard let notebookListViewController = navigationController.topViewController
            as? NotebooksListViewController else { return assertionFailure() }

        notebookListViewController.dataController = dataController
    }
}

