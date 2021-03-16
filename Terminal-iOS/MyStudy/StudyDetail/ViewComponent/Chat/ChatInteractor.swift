//
//  ChatInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class ChatInteractor: ChatInteractorProtocol {
    weak var presenter: ChatPresenterProtocol?
    var remoteDataManager: ChatRemoteDataManagerProtocol?
    var localDataManager: ChatLocalDataManagerProtocol?
    
    var studyID: Int?
    var userID: Int?
    var lastTimeStamp: Int?
    var arrangeChatTime: DispatchTime?
    var myChatUUIDList: [[String: Any]] = []
    var lastLocalChat: [Chat] = []
    var receiveFromSocketChat: [Chat] = []
    var mergeChatFromSocketFlag = false
    var nicknameList: [ChatParticipate] = []
    var totalChat: [Chat] = []
    var currentYear = ""
    var currentMonth = ""
    var currentDay = ""
    
    func connectSocket() {
        toDayDateSet()
        guard let id = KeychainWrapper.standard.string(forKey: "userID") else { return }
        self.userID = Int(id)
        getLastLocalChat {
            if self.lastLocalChat.isEmpty {
                self.remoteDataManager?.socketConnect(studyID: self.studyID!, date: nil)
            } else {
                self.remoteDataManager?.socketConnect(studyID: self.studyID!,
                                                      date: self.lastLocalChat.last!.date)
            }
        }
        //        //        작업간 슈가 코드 지우기 ㄴㄴ
        //                CoreDataManager.shared.tempRemoveAllChat()
    }
    
    func emit(message: String) {
        let chatUUID = UUID().uuidString
        let emitTime = DispatchTime.now()
        let tempChat = Chat(uuid: chatUUID,
                            studyID: studyID!,
                            userID: userID!,
                            nickname: "",
                            message: message,
                            date: Int(NSDate().timeIntervalSince1970) * 1000,
                            isTemp: true)
        totalChat.append(tempChat)
        myChatUUIDList.append(["UUID": chatUUID,
                               "time": emitTime,
                               "workItem": emitFailed(uuid: chatUUID)])
        arrangeChat()
        remoteDataManager?.emit(message: ["message": message, "uuid": chatUUID])
    }
    
    func emitFailed(uuid: String) -> DispatchWorkItem {
        let emitFailedWorkItem = DispatchWorkItem { [weak self] in
            self?.presenter?.emitFailed(uuid: uuid)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: emitFailedWorkItem)
        return emitFailedWorkItem
    }
    
    func disconnectSocket() {
        remoteDataManager?.disconnectSocket()
    }
    
    func getLastLocalChat(_ completion: @escaping () -> Void ) {
        // 로컬 챗 세팅
        lastLocalChat = CoreDataManager.shared.getCurrentChatInfo(studyID: studyID!)
        completion()
    }
    
    func receiveMessage(message: Chat) {
        // 소켓으로 넘어온 챗
        receiveFromSocketChat.append(message)
        arrangeChat()
    }
    
    func receiveLastChat(lastRemoteChat: BaseResponse<RemoteChatInfo>) {
        switch lastRemoteChat.result {
        case true:
            if let remoteChatInfo = lastRemoteChat.data {
                let remoteChat = remoteChatInfo.chatList
                nicknameList = remoteChatInfo.userList
                if !remoteChat.isEmpty {
                    // 기준이 될 라스트 타임스탬프 할당
                    lastTimeStamp = remoteChat.last?.date
                    // CoreDataManager에 lastRemoteChat 저장
                    CoreDataManager.shared.saveChatInfo(studyID: studyID!, chatList: remoteChat)
                    // 로컬 + 리모트 채팅을 프레젠터로 패스
                    if !lastLocalChat.isEmpty
                        && !remoteChat.isEmpty {
                        // 필요할 때만 넣어줌 (임시 뷰잉이기에 실제로 넣지않음)
                        lastLocalChat.append(Chat(uuid: "0",
                                                  studyID: studyID!,
                                                  userID: 0,
                                                  nickname: "__SYSTEM__",
                                                  message: "여기까지 읽으셨습니다.",
                                                  date: 0,
                                                  isTemp: false))
                    }
                    totalChat = setDaySystemMessage(chat: lastLocalChat + remoteChat)
                    // 여기서 날짜한번 세팅
                    presenter?.getLastChatResult(lastChat:
                                                    setNickname(chatList: totalChat))
                } else {
                    totalChat = setDaySystemMessage(chat: lastLocalChat)
                    // 여기서 날짜한번 세팅
                    presenter?.getLastChatResult(lastChat:
                                                    setNickname(chatList: totalChat))
                }
                
            }
        case false:
            // 리모트로부터 이전 채팅을 받아오지 못했을 때
            // 여기서 날짜한번 세팅
            presenter?.getLastChatResult(lastChat: lastLocalChat)
            guard let message = lastRemoteChat.message else { return }
            presenter?.showError(message: message)
        }
        
    }
    
    func mergeChatFromSocket() {
        mergeChatFromSocketFlag = true
        arrangeChatTime = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: arrangeChatTime! +  0.51) {
            self.arrangeChat()
        }
    }
    
    func arrangeChat() {
        guard let distance = arrangeChatTime?.distance(to: DispatchTime.now()).toDouble() else { return }
        if distance >= 0.5 {
            arrangeChatTime = DispatchTime.now()
            var reloadIndex: Int?
            if !receiveFromSocketChat.isEmpty
                // 소켓으로 넘어온 채팅이 있으면서
                && mergeChatFromSocketFlag {
                // 뷰에 과거채팅이 준비되어있을때
                var chatArray: [Chat] = []
                while !receiveFromSocketChat.isEmpty {
                    let first = receiveFromSocketChat.first!
                    if (lastTimeStamp != nil
                            && lastTimeStamp!
                            < first.date)
                        || lastTimeStamp == nil {
                        if first.date != 0 {
                            CoreDataManager.shared.saveChatInfo(studyID: studyID!,
                                                                chatList: [first])
                        }
                        // 여기서 날짜한번 세팅
                        chatArray.append(contentsOf: setDaySystemMessage(chat: [first]))
                        if let uuid = first.uuid {
                            // 소켓으로 들어온 것 중 내가보낸 것들을 검사 후
                            if let index = myChatUUIDList.firstIndex(where: { $0["UUID"] as? String == uuid }) {
                                // 토탈에서 과거 임시 채팅 삭제
                                if let totalChatIndex = totalChat.firstIndex(where: { $0.uuid == uuid }) {
                                    if reloadIndex == nil {
                                        reloadIndex = (totalChatIndex)
                                    }
                                    totalChat.remove(at: totalChatIndex)
                                }
                                // uuid 지워주고
                                if let workItem = myChatUUIDList[index]["workItem"] as? DispatchWorkItem {
                                    workItem.cancel()
                                }
                                myChatUUIDList.remove(at: index)
                            }
                        }
                    }
                    receiveFromSocketChat.removeFirst()
                }
                totalChat += chatArray
            }
            if reloadIndex != nil {
                reloadIndex = totalChat.count - reloadIndex!
            }
            presenter?.arrangedChatFromChat(chat: setNickname(chatList: totalChat),
                                            reloadIndex: reloadIndex ?? nil)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            if !self.receiveFromSocketChat.isEmpty {
                self.arrangeChat()
            }
        }
    }
    
    func setNickname(chatList: [Chat]) -> [Chat] {
        chatList.forEach { chatItem in
            nicknameList.forEach { nicknameItem in
                if chatItem.userID == nicknameItem.userID {
                    chatItem.nickname = nicknameItem.nickname
                }
            }
        }
        return chatList
    }
    
    func toDayDateSet() {
        let calender = Calendar.current
        let date = Date(timeIntervalSince1970: NSDate().timeIntervalSince1970)
        currentYear = "\(calender.component(.year, from: date))"
        currentMonth = "\(calender.component(.month, from: date))"
        currentDay = "\(calender.component(.day, from: date))"
    }
    
    func setDaySystemMessage(chat: [Chat]) -> [Chat] {
        var result = chat
        var preYear = ""
        var preMonth = ""
        var preDay = ""
        
        for i in 0..<result.count {
            let timeStamp = result[i].date
            let calender = Calendar.current
            let date = Date(timeIntervalSince1970: TimeInterval(timeStamp) / 1000)
            let year = "\(calender.component(.year, from: date))"
            let month = "\(calender.component(.month, from: date))"
            let day = "\(calender.component(.day, from: date))"
            let systemMessage = Chat(uuid: "0",
                                     studyID: studyID!,
                                     userID: 0,
                                     nickname: "__SYSTEM__",
                                     message: year + "년 " + month + "월 " + day + "일",
                                     date: timeStamp,
                                     isTemp: nil)
            
            if preYear != year
                || preMonth != month
                || preDay != day {
                result.insert(systemMessage, at: i == 0 ? 0 : i - 1)
                if currentYear == year
                    || currentMonth == month
                    || currentDay == day {
                    currentYear = year
                    currentMonth = month
                    currentDay = day
                }
            }

            preYear = year
            preMonth = month
            preDay = day
        }
        
        return result
    }
    
    func sessionTaskError(message: String) {
        
    }
    
    func setNicknameList(list: [ChatParticipate]) {
        nicknameList = Array(combine(nicknameList, list))
    }
    
    func combine<T>(_ arrays: [T]?...) -> Set <T> {
        return arrays.compactMap {$0}.compactMap {Set($0)}.reduce(Set<T>()) {$0.union($1)}
    }
}
