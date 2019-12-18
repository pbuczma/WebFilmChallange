//
//  AppDelegate.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 16/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let filmListNavigationController = UINavigationController()
               let filmListViewController = FilmListViewController()
               
               filmListNavigationController.addChild(filmListViewController)
               
               self.window = UIWindow(frame: UIScreen.main.bounds)
               self.window!.rootViewController = filmListNavigationController
               self.window!.backgroundColor = UIColor.white
               self.window!.makeKeyAndVisible()
        
        
        
        return true
    }



}

