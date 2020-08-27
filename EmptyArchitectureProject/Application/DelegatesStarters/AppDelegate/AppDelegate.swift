//
//  AppDelegate.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import RealmSwift
import Reachability
import NotificationBannerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var appCoordinator: AppCoordinator?
    let reachability = try! Reachability()
    var isConnected: Bool = true
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        if #available(iOS 13, *) {
            // do nothing / do things that should only be done for iOS 13
            UIApplication.shared.registerForRemoteNotifications()
            
        } else {
            
            let appWindow = UIWindow(frame: UIScreen.main.bounds)
            let navigationController = UINavigationController()
            appCoordinator = AppCoordinator(navigationController: navigationController)
            appCoordinator?.start()
            
            appWindow.rootViewController = navigationController
            appWindow.makeKeyAndVisible()
            let appearance = UITabBarItem.appearance()
            let attributes = [NSAttributedString.Key.font:FontUtils.note.font]
            appearance.setTitleTextAttributes(attributes, for: .normal)
            window = appWindow
            appCoordinator?.window = window
            
        }
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        _ = try! Realm()
        
        
        
        /* -------------------------Reachability-------------------------- */
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
            self.isConnected = self.reachability.connection != .unavailable
        }catch{
            print("could not start reachability notifier")
        }
        
        return true
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
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "EmptyArchitectureProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    @objc func reachabilityChanged(note: Notification) {
        let bannerOffline = FloatingNotificationBanner(customView: ConnectionStateBanner(message: "No internet Connexion", color: .gray))

        
          
        bannerOffline.transparency = 0.60
        bannerOffline.autoDismiss = true
        bannerOffline.haptic = .medium
  
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            bannerOffline.dismiss()

            
        case .cellular:
            print("Reachable via Cellular")

    bannerOffline.dismiss()
        case .unavailable:
          //  bannerOnline.dismiss()
            bannerOffline.show(queuePosition: QueuePosition.back,
                        bannerPosition: .top,
                        cornerRadius: 10)
            
            print("Network not reachable")
        case .none:
            print("Network not reachable")
        }
    }
    
}
