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
import SwiftyJSON
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var goView: MyStudyDetailView?
    var studyID: String = ""
    var pushEvent: AlarmCase?
    var studyTitle: String = ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let home = HomeView()
        let main = ViewController()
        
        // 리프레쉬 토큰이 없으면 -> 홈화면
        if KeychainWrapper.standard.string(forKey: "refreshToken") == nil {
            KeychainWrapper.standard.set("temp", forKey: "accessToken")
            let howView = UINavigationController(rootViewController: home)
            window?.rootViewController = howView
        } else {
            print("토큰이 유효합니다..")
            print("로그인 완료")
            print("accessToken : ", KeychainWrapper.standard.string(forKey: "accessToken")!)
            window?.rootViewController = main
            if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
                if let studyID = notification["study_id"] as? String,
                   let pushEvent = notification["pushEvent"] as? String {
                    self.studyID = studyID
                    self.pushEvent = AlarmCase(rawValue: pushEvent)
                }
                main.selectedIndex = 1
            }
            
            /// 유저정보 조회를 통해서 리프레쉬 토큰 유효성 검사
            let userID = KeychainWrapper.standard.string(forKey: "userID")
            
            TerminalNetworkManager
                .shared
                .session
                .request(TerminalRouter.userInfo(id: userID!))
                .validate(statusCode: 200...422)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        print("리프레쉬 유효성 검사 성공")
                    case .failure(let err):
                        print("실패:", err)
                    }
                }
        }
        
        window?.makeKeyAndVisible()
        
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
        return true
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        if let studyID = userInfo["study_id"] as? String,
           let pushEvent = userInfo["pushEvent"] as? String {
            self.studyID = studyID
            self.pushEvent = AlarmCase(rawValue: pushEvent)
            //여기에 추가적으로 alertID,
        }

        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        sleep(1)
        
        let event = self.pushEvent
        let studyID = Int(self.studyID)!
        
        switch event {
        case .chat:
            break
        case .studyDelete:
            break
        case .studyUpdate, .studyHostDelegate:
            if let view = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID, studyTitle: "임시 타이틀")
                as? MyStudyDetailView {
                view.getPushEvent = true
                goView = view
                if let tabVC = self.window?.rootViewController as? UITabBarController,
                   let navVC = tabVC.selectedViewController as? UINavigationController {

                    navVC.pushViewController(goView!, animated: true)
                }
            }
        case .newApply:
            if let view = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID, studyTitle: "임시 타이틀")
                as? MyStudyDetailView {
                view.getPushEvent = true
                view.applyState = true
                goView = view
                if let tabVC = self.window?.rootViewController as? UITabBarController,
                   let navVC = tabVC.selectedViewController as? UINavigationController {

                    navVC.pushViewController(goView!, animated: true)
                }
            }
        case .newNotice, .updatedNotice:
            if let view = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID, studyTitle: "임시 타이틀 ")
                as? MyStudyDetailView {
                view.noticePushEvent = true
                goView = view
                if let tabVC = self.window?.rootViewController as? UITabBarController,
                   let navVC = tabVC.selectedViewController as? UINavigationController {
                    navVC.pushViewController(goView!, animated: true)
                }
            }
        case .applyAllowed:
            break
        case .applyRejected:
            break
        case .testPush:
            break
        case .none:
            print("지정되어있지 않은 메세지 들어옴 ")
        }
        completionHandler()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
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
        container.loadPersistentStores(completionHandler: { storeDescription, error in
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
