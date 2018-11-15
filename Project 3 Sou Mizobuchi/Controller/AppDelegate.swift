//
//  AppDelegate.swift
//  Project 3 Sou Mizobuchi
//
//  Created by user144546 on 11/13/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    private struct StoryBoard {
        static let MainStoryBoardName = "Main"
        static let MapVCIdentifier = "DetailVC"
    }

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let splitViewController = window!.rootViewController as? UISplitViewController {
            splitViewController.delegate = self
        }
        
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        if let navVC = primaryViewController as? UINavigationController {
            for controller in navVC.viewControllers {
                if controller.restorationIdentifier == StoryBoard.MapVCIdentifier {
                    return controller
                }
            }
        }
        let storyboard = UIStoryboard(name: StoryBoard.MainStoryBoardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: StoryBoard.MapVCIdentifier)
    }
}

