//
//  AppDelegate.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import CoreData

import Firebase
import FirebaseAnalytics
import Kingfisher
import SwiftKeychainWrapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 임시 슈가 코드
        print("Refresh : ", KeychainWrapper.standard.string(forKey: "refreshToken") as Any)
        print("Access : ", KeychainWrapper.standard.string(forKey: "accessToken") as Any)
        
        // firebase 연동
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(FirebaseLoggerLevel.min)
        if let userID = KeychainWrapper.standard.string(forKey: "userID") {
            Crashlytics.crashlytics().setCustomValue(userID, forKey: "userID")
            Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                AnalyticsParameterItemID: "\(userID)"
            ])
        }
        
        // Noti Request
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]) { _, error in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        if launchOptions?[.remoteNotification] == nil {
            window = UIWindow()
            let launchView = LaunchWireFrame.createLaunchModule()
            let nav = UINavigationController(rootViewController: launchView)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        sleep(1)
        var goView: UIViewController?
        let userInfo = response.notification.request.content.userInfo
        if let alertID = userInfo["alert_id"] as? Int,
           let userID = KeychainWrapper.standard.string(forKey: "userID") {
            guard let id = Int(userID) else { return }
            TerminalNetworkManager
                .shared
                .session
                .request(TerminalRouter.alertConfirm(userID: id, alertID: alertID))
                .validate()
                .responseData { response in
                    print(response.result)
                }
        }
        guard let eventValue    = userInfo["pushEvent"] as? String else { return }
        guard let studyID       = userInfo["study_id"] as? String else { return }
        guard let event         = AlarmType(rawValue: eventValue) else { return }
        guard let id            = Int(studyID) else { return }
        guard let studyDetailView = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: id, studyTitle: "") as? MyStudyDetailView else { return }
        
        switch event {
        case .chat:
            studyDetailView.viewState = .Chat
            goView = studyDetailView
        case .studyUpdate,
             .studyHostDelegate,
             .applyAllowed:
            studyDetailView.viewState = .StudyDetail
            goView = studyDetailView
            
        case .newApply:
            studyDetailView.applyState = true
            goView = studyDetailView
            
        case .newNotice,
             .updatedNotice:
            studyDetailView.viewState = .Notice
            goView = studyDetailView
            
        case .applyRejected, .studyDelete:
            let notificationListView = NotificationWireFrame.createModule()
            goView = notificationListView
            
        case .testPush, .undefined: break
            
        }
        if let tabVC = self.window?.rootViewController as? UITabBarController,
           let navVC = tabVC.selectedViewController as? UINavigationController {
            navVC.rootViewController?.dismiss(animated: false, completion: nil)
            guard let targetView = goView else { return }
            var targetParentView: UIViewController?
            navVC.viewControllers.forEach {
                if type(of: $0) == type(of: targetView) {
                    if let popPoint = targetParentView {
                        navVC.popToViewController(popPoint, animated: false)
                        navVC.pushViewController(targetView, animated: true)
                    }
                    return
                } else {
                    if navVC.viewControllers.last == $0 {
                        navVC.pushViewController(targetView, animated: true)
                    }
                }
                targetParentView = $0
            }
        } else {
            window = UIWindow()
            let launchView = LaunchWireFrame.createLaunchModule(studyID: id, pushEvent: event)
            window?.rootViewController = launchView
            window?.makeKeyAndVisible()
        }
        completionHandler()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        KeychainWrapper.standard.remove(forKey: "pushToken")
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        let pushToken = KeychainWrapper.standard.set(deviceTokenString, forKey: "pushToken")
        print("pushToken 성공여부:", pushToken)
        print("pushToken:", KeychainWrapper.standard.string(forKey: "pushToken")!)
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
        container.loadPersistentStores(completionHandler: { _, error in
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
