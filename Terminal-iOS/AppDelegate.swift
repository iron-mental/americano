//
//  AppDelegate.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftKeychainWrapper
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let home = HomeView()

        // 리프레쉬 토큰이 없으면 -> 로그인
        if KeychainWrapper.standard.string(forKey: "refreshToken") == nil {
            KeychainWrapper.standard.set("temp", forKey: "accessToken")
            let howView = UINavigationController(rootViewController: home)
            window?.rootViewController = howView
        } else {
            print("토큰이 유효합니다..")
            print("로그인 완료")
            print("accessToken : ", KeychainWrapper.standard.string(forKey: "accessToken")!)
            let main = ViewController()
            window?.rootViewController = main
        }

        window?.makeKeyAndVisible()
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if let error = error {
                print(error)
            }
            
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        
        return true
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            let userInfo = notification.request.content.userInfo
            print("Receive notification in the foreground \(userInfo)")
            let pref = UserDefaults.init(suiteName: "terminal_notification")
            pref?.set(userInfo, forKey: "NOTIFI_DATA")

            completionHandler([.alert, .badge, .sound])
        }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        let pushToken = KeychainWrapper.standard.set(deviceTokenString, forKey: "pushToken")
        print("pushToken 성공여부:",pushToken)
        print("pushToken:",KeychainWrapper.standard.string(forKey: "pushToken")!)
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TerminalCoreData")
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
}

