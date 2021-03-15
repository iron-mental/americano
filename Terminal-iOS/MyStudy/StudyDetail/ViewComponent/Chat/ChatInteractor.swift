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
    
    var lastLocalChat: [Chat] = []
    var receiveFromSocketChat: [Chat] = []
    
    var lastTimeStamp: Int?
    var mergeChatFromSocketFlag = false
    var arrangeChatTime: DispatchTime?
    var nicknameList: [ChatParticipate] = []
    var myChatUUIDList: [[String: Any]] = []
    
    var totalChat: [Chat] = []
    var userID: Int?
    func connectSocket() {
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
//        작업간 슈가 코드 지우기 ㄴㄴ
//        CoreDataManager.shared.tempRemoveAllChat()
    }
    
    func emit(message: String) {
        let chatUUID = UUID().uuidString
        let emitTime = DispatchTime.now()
        myChatUUIDList.append(["UUID": chatUUID,
                               "time": emitTime])
        let tempChat = Chat(uuid: chatUUID,
                            studyID: studyID!,
                            userID: userID!,
                            nickname: nil,
                            message: message,
                            date: Int(NSDate().timeIntervalSince1970))
        
        
        totalChat += setNickname(chatList: [tempChat])
        // 뷰에 미리 보여주기 UUID 넣어서
        // presenter.tempshowchat~
        
        remoteDataManager?.emit(message: ["message": message, "uuid": chatUUID])
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
        if let uuid = message.uuid {
            //성공한 채팅 처리
            if let index = myChatUUIDList.firstIndex(where: { $0["UUID"] as? String == uuid }) {
                myChatUUIDList.remove(at: index)
            }
        }
        arrangeChat()
    }
    
    func receiveLastChat(lastRemoteChat: BaseResponse<RemoteChatInfo>) {
        switch lastRemoteChat.result {
        case true:
            if let remoteChatInfo = lastRemoteChat.data {
                let remoteChat = remoteChatInfo.chatList
                nicknameList = remoteChatInfo.userList
//                presenter?.getParticipateNickname(nicknameList: nicknameList)
                
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
                                                  date: 0))
                    }
                    totalChat = lastLocalChat + remoteChat
                    presenter?.getLastChatResult(lastChat:
                                                    setNickname(chatList: totalChat))
                } else {
                    totalChat = lastLocalChat
                    presenter?.getLastChatResult(lastChat:
                                                    setNickname(chatList: totalChat))
                }
                
            }
        case false:
            // 리모트로부터 이전 채팅을 받아오지 못했을 때
            presenter?.getLastChatResult(lastChat: lastLocalChat)
            guard let message = lastRemoteChat.message else { return }
            presenter?.showError(message: message)
        }
        
    }
    
    func mergeChatFromSocket() {
        mergeChatFromSocketFlag = true
        arrangeChatTime = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: arrangeChatTime! +  0.251) {
            self.arrangeChat()
        }
    }
    
    func arrangeChat() {
        guard let distance = arrangeChatTime?.distance(to: DispatchTime.now()).toDouble() else { return }
        if distance >= 0.25 {
            arrangeChatTime = DispatchTime.now()
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
                        chatArray.append(first)
                    }
                    receiveFromSocketChat.removeFirst()
                }
                totalChat += chatArray
                presenter?.arrangedChatFromChat(chat: setNickname(chatList: totalChat))
                CoreDataManager.shared.saveChatInfo(studyID: studyID!,
                                                    chatList: chatArray)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
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
    
    func sessionTaskError(message: String) {
        
    }
    
    func setNicknameList(list: [ChatParticipate]) {
        nicknameList = Array(combine(nicknameList, list))
    }
    
    func combine<T>(_ arrays: Array<T>?...) -> Set<T> {
        return arrays.compactMap {$0}.compactMap {Set($0)}.reduce(Set<T>()) {$0.union($1)}
    }
}
