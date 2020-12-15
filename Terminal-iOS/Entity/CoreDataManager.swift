//
//  CoreDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    lazy var context = appDelegate.persistentContainer.viewContext
    
    func putUserInfo(userInfo: UserInfo) {
        let newUserInfo = CoreUserInfo(context: context)
        newUserInfo.id = Int64(userInfo.id)
        newUserInfo.nickname = userInfo.nickname ?? nil
        newUserInfo.email = userInfo.email ?? nil
        newUserInfo.image = userInfo.image ?? nil
        newUserInfo.introduce = userInfo.introduce ?? nil
        newUserInfo.address = userInfo.address ?? nil
        newUserInfo.careerTitle = userInfo.careerTitle ?? nil
        newUserInfo.careerContents = userInfo.careerContents ?? nil
        newUserInfo.snsLinkedin = userInfo.snsLinkedin ?? nil
        newUserInfo.snsWeb = userInfo.snsWeb ?? nil
        newUserInfo.snsGithub = userInfo.snsGithub ?? nil
        newUserInfo.emailVerified = userInfo.emailVerified
        newUserInfo.createdAt = userInfo.createdAt ?? nil
        do {
            try context.save()
            print("CoreData 저장 성공")
        } catch {
            print("삐빅 CoreUserInfo 에러~~")
        }
    }
    
    func getUserinfo() {
        do {
            let result = try CoreDataManager.shared.context.fetch(CoreUserInfo.fetchRequest()) as! [CoreUserInfo]
            for record in result {
                print(record.id)
            }
        }
        catch {
            
        }
//        return []
    }
}
