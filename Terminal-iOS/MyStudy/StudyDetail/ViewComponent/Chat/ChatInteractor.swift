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
    var viewingChat: [Chat] = []
    var currentYear = ""
    var currentMonth = ""
    var currentDay = ""
    
    // MARK: 로컬데이터 get 후 socket 연결 동기 처리
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
///        작업간 슈가 코드 지우기 ㄴㄴ
///        CoreDataManager.shared.tempRemoveAllChat()
    }
    
    // MARK: 로컬 챗 세팅
    func getLastLocalChat(_ completion: @escaping () -> Void ) {
        lastLocalChat = CoreDataManager.shared.getCurrentChatInfo(studyID: studyID!)
        completion()
    }
    
    // MARK: 리모트데이터 get 후 처리
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
                        guard let lastData = lastLocalChat.last?.date else { return }
                        lastLocalChat.append(Chat(uuid: "0",
                                                  studyID: studyID!,
                                                  userID: 0,
                                                  nickname: "__SYSTEM__",
                                                  message: "여기까지 읽으셨습니다.",
                                                  date: lastData,
                                                  isTemp: nil))
                    }
                }
                totalChat = setDayPreChat(chat: lastLocalChat + remoteChat)
                if lastLocalChat.count > 50 {
                    // 로컬 50개 + 리모트 먼저 뷰잉
                    viewingChat = Array(totalChat[(totalChat.count - remoteChat.count - 50)..<totalChat.count])
                    totalChat = Array(totalChat[0..<(totalChat.count - remoteChat.count - 50)])
                } else {
                    viewingChat = totalChat
                }
                presenter?.getLastChatResult(lastChat:
                                                setNickname(chatList: viewingChat))
            }
        case false:
            // 리모트로부터 이전 채팅을 받아오지 못했을 때
            presenter?.getLastChatResult(lastChat: lastLocalChat)
            guard let message = lastRemoteChat.message else { return }
            presenter?.showError(message: message)
        }
        
    }
    
    // MARK: socket emit 전 temp chat 처리
    func emit(message: String) {
        let chatUUID = UUID().uuidString
        let tempChat = Chat(uuid: chatUUID,
                            studyID: studyID!,
                            userID: userID!,
                            nickname: "",
                            message: message,
                            date: Int(NSDate().timeIntervalSince1970) * 1000,
                            isTemp: true)
        viewingChat.append(tempChat)
        myChatUUIDList.append(["UUID": chatUUID,
                               "workItem": emitFailed(uuid: chatUUID)])
        arrangeChat()
        remoteDataManager?.emit(message: ["message": message, "uuid": chatUUID])
    }
    
    // MARK: 페이지네이션
    func getPreChat() {
        if totalChat.count > 50 {
            let preChat = Array(totalChat[(totalChat.count - 50)..<totalChat.count])
            totalChat = Array(totalChat[0..<(totalChat.count - 50)])
            viewingChat = preChat + viewingChat
        } else {
            viewingChat = totalChat + viewingChat
        }
        presenter?.getPreChatResult(pagingChat: viewingChat)
    }
    
    // MARK: 전송 실패 예약함수
    func emitFailed(uuid: String) -> DispatchWorkItem {
        let emitFailedWorkItem = DispatchWorkItem { [weak self] in
            self?.presenter?.emitFailed(uuid: uuid)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: emitFailedWorkItem)
        return emitFailedWorkItem
    }
    
    // MARK: 소켓 연결 해제 (현재 쓸 계획은 없는듯)
    func disconnectSocket() {
        remoteDataManager?.disconnectSocket()
    }
    
    // MARK: 소켓으로 넘어온 챗 쌓아두기
    func receiveMessage(message: Chat) {
        receiveFromSocketChat.append(message)
        arrangeChat()
    }
    
    // MARK: 뷰에 로컬+리모트가 세팅됐을 때 호출
    func mergeChatFromSocket() {
        mergeChatFromSocketFlag = true
        arrangeChatTime = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: arrangeChatTime! +  0.31) {
            self.arrangeChat()
        }
    }
    
    // MARK: 소켓을 통한 모든 챗은 이 함수를 거쳐 감 ( 뷰로 가는 길이 하나여야 뷰에 무리가 가지않는다고 판단 )
    func arrangeChat() {
        guard let distance = arrangeChatTime?.distance(to: DispatchTime.now()).toDouble() else { return }
        // 호출된지 0.3초보다 적게 지났으면 진입 X
        if distance >= 0.3 {
            // 현재 시간 갱신
            arrangeChatTime = DispatchTime.now()
            // 뷰에 리로드할 인덱스 준비
            var reloadIndex: Int?
            if !receiveFromSocketChat.isEmpty
                // 소켓으로 넘어온 채팅이 있으면서
                && mergeChatFromSocketFlag {
                // 뷰에 과거채팅이 준비되어있을때
                var chatArray: [Chat] = []
                while !receiveFromSocketChat.isEmpty {
                    let first = receiveFromSocketChat.first!
                    // 중복 제거 if문
                    if (lastTimeStamp != nil
                            && lastTimeStamp!
                            < first.date)
                        || lastTimeStamp == nil {
                            CoreDataManager.shared.saveChatInfo(studyID: studyID!,
                                                                chatList: [first])
                        // 여기서 날짜한번 세팅
                        chatArray.append(contentsOf: setDaySocketChat(chat: [first]))
                        if let uuid = first.uuid {
                            // 소켓으로 들어온 것 중 내가보낸 것이 들어왔다면
                            if let index = myChatUUIDList.firstIndex(where: { $0["UUID"] as? String == uuid }) {
                                // totalChat에서 임시 채팅 제거
                                if let totalChatIndex = viewingChat.firstIndex(where: { $0.uuid == uuid }) {
                                    if reloadIndex == nil {
                                        reloadIndex = (totalChatIndex)
                                    }
                                    viewingChat.remove(at: totalChatIndex)
                                }
                                if let workItem = myChatUUIDList[index]["workItem"] as? DispatchWorkItem {
                                    // 전송실패 예약 함수 취소
                                    workItem.cancel()
                                }
                                // uuid관리 리스트 지워줌
                                myChatUUIDList.remove(at: index)
                            }
                        }
                    }
                    receiveFromSocketChat.removeFirst()
                }
                viewingChat += chatArray
            }
            // 리로드할 인덱스 할당
            if reloadIndex != nil {
                reloadIndex = viewingChat.count - reloadIndex!
            }
            presenter?.arrangedChatFromChat(chat: setNickname(chatList: viewingChat),
                                            reloadIndex: reloadIndex ?? nil)
        }
        // 함수 종료직전 또 다시 소켓으로 부터 쌓여있으면 재귀로 호출
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            if !self.receiveFromSocketChat.isEmpty {
                self.arrangeChat()
            }
        }
    }
    
    // MARK: 서버가 내려준 user_list를 통해 닉네임 할당 ( 닉네임 변경 대응 )
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
    
    // MARK: 오늘 날짜 세팅
    func toDayDateSet() {
        let calender = Calendar.current
        let date = Date(timeIntervalSince1970: NSDate().timeIntervalSince1970)
        currentYear = "\(calender.component(.year, from: date))"
        currentMonth = "\(calender.component(.month, from: date))"
        currentDay = "\(calender.component(.day, from: date))"
    }

    func setDayPreChat(chat: [Chat]) -> [Chat] {
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
                result.insert(systemMessage, at: i)
            }
            
            preYear = year
            preMonth = month
            preDay = day
        }
        if result.isEmpty {
            //첫 채팅일 시 날짜 배정
            let systemMessage = Chat(uuid: "0",
                                     studyID: studyID!,
                                     userID: 0,
                                     nickname: "__SYSTEM__",
                                     message: currentYear + "년 " + currentMonth + "월 " + currentDay + "일",
                                     date: 0,
                                     isTemp: nil)
            result.insert(systemMessage, at: 0)
        }
        
        return result
    }
    
    func setDaySocketChat(chat: [Chat]) -> [Chat] {
        var result = chat
        
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
            if currentYear != year
                || currentMonth != month
                || currentDay != day {
                result.insert(systemMessage, at: i)
                currentYear = year
                currentMonth = month
                currentDay = day
            }
        }
        
        return result
    }
    
    func sessionTaskError(message: String) {
        presenter?.showError(message: message)
    }
    
    func setNicknameList(list: [ChatParticipate]) {
        nicknameList = Array(combine(nicknameList, list))
    }
    
    func combine<T>(_ arrays: [T]?...) -> Set <T> {
        return arrays.compactMap {$0}.compactMap {Set($0)}.reduce(Set<T>()) {$0.union($1)}
    }
}
