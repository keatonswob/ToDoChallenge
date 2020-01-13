//
//  AppDelegate.swift
//  ToDoChallenge
//
//  Created by Keaton Swoboda on 1/7/20.
//  Copyright © 2020 Keaton Swoboda. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootViewController: UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {        
        let listViewModel = ListViewModel()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let listViewController = ListViewController(viewModel: listViewModel)
        rootViewController = UINavigationController(rootViewController: listViewController)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }

}

