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
    var goView: MyStudyDetailView?
    var studyID: String = ""
    var pushEvent: String = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let home = HomeView()
        let main = ViewController()
      
        // 리프레쉬 토큰이 없으면 -> 로그인
        if KeychainWrapper.standard.string(forKey: "refreshToken") == nil {
            KeychainWrapper.standard.set("temp", forKey: "accessToken")
            let howView = UINavigationController(rootViewController: home)
            window?.rootViewController = howView
        } else {
            print("토큰이 유효합니다..")
            print("로그인 완료")
            print("accessToken : ", KeychainWrapper.standard.string(forKey: "accessToken")!)
            
            if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
                let destination = notification["destination"] as? NSDictionary
                let pushEvent = notification["pushEvent"] as? String
                if let studyID = destination!["study_id"] as? String,
                   let pushEvent = pushEvent {
                    self.studyID = studyID
                    self.pushEvent = pushEvent
                }
                main.selectedIndex = 1
                main
                window?.rootViewController = main
            } else {
                window?.rootViewController = main
            }
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
        
        let destination = userInfo["destination"] as? NSDictionary
        let pushEvent = userInfo["pushEvent"] as? String
        
        if let studyID = destination!["study_id"] as? String,
           let pushEvent = pushEvent {
            self.studyID = studyID
            self.pushEvent = pushEvent
        }
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        sleep(1)
        
        let event = self.pushEvent
        let studyID = Int(self.studyID)!

        switch event {
        case "apply_new":
            if let view = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID)
                as? MyStudyDetailView {
                view.getPushEvent = true
                goView = view
            }
        case "study_update", "study_delegate":
            if let view = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID)
                as? MyStudyDetailView {
                goView = view
            }
        case "notice_new", "notice_update":
            if let view = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID)
                as? MyStudyDetailView {
                view.getPushEvent = true
                goView = view
            }
        default:
            break
        }


        if let tabVC = self.window?.rootViewController as? UITabBarController,
           let navVC = tabVC.selectedViewController as? UINavigationController {

            navVC.pushViewController(goView!, animated: true)
        }
        
        completionHandler()
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

