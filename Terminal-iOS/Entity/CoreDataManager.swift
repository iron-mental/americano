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
    
    // MARK: UserInfo
    func createUserInfo(userInfo: UserInfo) {
        let newUserInfo = CoreUserInfo(context: context)
        
        newUserInfo.id = Int64(userInfo.id)
        newUserInfo.nickname = userInfo.nickname
        newUserInfo.email = userInfo.email
        newUserInfo.image = userInfo.image ?? nil
        newUserInfo.introduce = userInfo.introduce ?? nil
        newUserInfo.sido = userInfo.sido ?? nil
        newUserInfo.sigungu = userInfo.sigungu ?? nil
        newUserInfo.careerTitle = userInfo.careerTitle ?? nil
        newUserInfo.careerContents = userInfo.careerContents ?? nil
        newUserInfo.snsLinkedin = userInfo.snsLinkedin ?? nil
        newUserInfo.snsWeb = userInfo.snsWeb ?? nil
        newUserInfo.snsGithub = userInfo.snsGithub ?? nil
        newUserInfo.emailVerified = userInfo.emailVerified
        newUserInfo.createdAt = String(userInfo.createdAt)
        
        do {
            try context.save()
            print("CoreData 저장 성공")
        } catch {
            print("삐빅 CoreUserInfo 에러~~")
        }
    }
    
    func putUserInfo(userInfo: UserInfo) {
        var updatingUserInfo: CoreUserInfo
        do {
            //userInfo.id와 매칭 되는 애만 불러와야함
            let coreUserInfo = try CoreDataManager.shared.context.fetch(CoreUserInfo.fetchRequest()) as! [CoreUserInfo]
            updatingUserInfo = coreUserInfo.first!
            updatingUserInfo.nickname = userInfo.nickname
            updatingUserInfo.email = userInfo.email
            updatingUserInfo.image = userInfo.image ?? nil
            updatingUserInfo.introduce = userInfo.introduce ?? nil
            updatingUserInfo.sido = userInfo.sido ?? nil
            updatingUserInfo.sigungu = userInfo.sigungu ?? nil
            updatingUserInfo.careerTitle = userInfo.careerTitle ?? nil
            updatingUserInfo.careerContents = userInfo.careerContents ?? nil
            updatingUserInfo.snsLinkedin = userInfo.snsLinkedin ?? nil
            updatingUserInfo.snsWeb = userInfo.snsWeb ?? nil
            updatingUserInfo.snsGithub = userInfo.snsGithub ?? nil
            updatingUserInfo.emailVerified = userInfo.emailVerified
            updatingUserInfo.createdAt = String(userInfo.createdAt)
            try context.save()
            
        } catch {
            print("putUserInfo 오류")
        }
    }
    
    func getUserinfo() -> UserInfo? {
        var userInfo: UserInfo?
        do {
            let result = try CoreDataManager.shared.context.fetch(CoreUserInfo.fetchRequest()) as! [CoreUserInfo]
            for record in result {
                userInfo = UserInfo(id: Int(record.id),
                                    nickname: record.nickname ?? "nicknameTemp",
                                    email: record.email ?? "emailTemp",
                                    image: record.image,
                                    introduce: record.introduce,
                                    sido: record.sido,
                                    sigungu: record.sigungu,
                                    careerTitle: record.careerTitle,
                                    careerContents: record.careerContents,
                                    snsLinkedin: record.snsLinkedin,
                                    snsWeb: record.snsWeb,
                                    snsGithub: record.snsGithub,
                                    emailVerified: true,
                                    createdAt: 0)
                break
            }
            return userInfo
        } catch {
            return nil
        }
    }
    
    // MARK: Chat
    func saveChatInfo(studyID: Int, chatList: [Chat]) {
        var remoteChatList = chatList
        let fetchRequest: NSFetchRequest<CoreChatInfo> = CoreChatInfo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "studyID == %@", String(studyID))
        do {
            var currentChatInfo: [CoreChatInfo] = []
            currentChatInfo = try CoreDataManager.shared.context.fetch(fetchRequest)
            if currentChatInfo.isEmpty {
                // 스터디 최초 채팅
                let newCoreChatInfo = CoreChatInfo(context: context)
                newCoreChatInfo.studyID = Int64(studyID)
                newCoreChatInfo.chatList = remoteChatList
                currentChatInfo = [newCoreChatInfo]
            } else {
                // 기존 채팅에 추가
                while !remoteChatList.isEmpty {
                    if (currentChatInfo[0].chatList?.last!.date)! >= remoteChatList.first!.date {
                        remoteChatList.removeFirst()
                    } else {
                        break
                    }
                }
                currentChatInfo[0].chatList! += remoteChatList
            }
            try context.save()
        } catch {
            print("실패다")
        }
    }
    
    func getCurrentChatInfo(studyID: Int) -> [Chat] {
        let fetchRequest: NSFetchRequest<CoreChatInfo> = CoreChatInfo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "studyID == %@", String(studyID))
        do {
            var currentChatInfo: [CoreChatInfo] = []
            currentChatInfo = try CoreDataManager.shared.context.fetch(fetchRequest)
            if currentChatInfo.isEmpty {
                //로컬에 챗 없음
                return []
            } else {
                if let currentLocalChat = currentChatInfo[0].chatList {
                    //로컬에 챗 없음
                    return currentLocalChat
                }
            }
        } catch {
            // 코어데이터 디코딩 실패
            return []
        }
        return []
    }
    
    func tempRemoveAllChat() {
        let request: NSFetchRequest<NSFetchRequestResult> = CoreChatInfo.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.context.execute(delete)
        } catch {
        }
    }
}
