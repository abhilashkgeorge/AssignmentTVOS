//
//  AppDelegate.swift
//  AssignementTVOS
//
//  Created by Abhilash k George on 26/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let tabBarController = window?.rootViewController  as? UITabBarController {
            
            var viewController = [UIViewController]()
            
           
            if let listController = tabBarController.storyboard?.instantiateViewController(withIdentifier: "list") as? MasterVC {
                listController.title = "List"
                viewController.append(listController)
                    
                
            }

            viewController.append(createSearch(storyboard: tabBarController.storyboard))
            tabBarController.viewControllers = viewController
        }
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func createSearch(storyboard: UIStoryboard?) -> UIViewController {
        guard let listController = storyboard?.instantiateViewController(withIdentifier: "list") as? MasterVC else { fatalError("Instantiation Failed!!!!")}
        
        let searchController = UISearchController(searchResultsController: listController)
        searchController.searchResultsUpdater = listController
        
        let searchContainer = UISearchContainerViewController(searchController: searchController)
        searchContainer.title = "Search"
        
        return searchContainer
    }


}

