//
//  ChatInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ChatInteractor: ChatInteractorProtocol {
    weak var presenter: ChatPresenterProtocol?
    var remoteDataManager: ChatRemoteDataManagerProtocol?
    var localDataManager: ChatLocalDataManagerProtocol?
    var studyID: Int?
    var lastLocalChat: [Chat] = []
    var receiveFromSocketChat: [Chat] = []
    var lastTimeStamp: Int?
    var mergeChatFromSocketFlag = false
    
    func connectSocket() {
        getLastLocalChat {
            self.remoteDataManager?.socketConnect(studyID: self.studyID!)
        }
    }
    func emit(message: String) {
        remoteDataManager?.emit(message: message)
    }
    func disconnectSocket() {
        remoteDataManager?.disconnectSocket()
    }
    func getLastLocalChat(_: @escaping () -> Void ) {
        //로컬 챗 세팅
        lastLocalChat = CoreDataManager.shared.getCurrentChatInfo(studyID: studyID!)
    }
    func receiveMessage(message: Chat) {
        //챗 from socket
        receiveFromSocketChat.append(message)
        arrangeChat()
    }
    func receiveLastChat(lastRemoteChat: [Chat]) {
        //기준이 될 라스트 타임스탬프 할당
        lastTimeStamp = lastRemoteChat.last?.date
        //로컬에 가지고온 애를 할당하는거 추가
        //      CoreDataManager save chat 블라블라~
        //로컬 + 리모트 채팅을 프레젠터로 패스
        presenter?.getLastChatResult(lastChat: lastLocalChat + lastRemoteChat)
    }
    func mergeChatFromSocket() {
        //중복되었다면 지워주고
        if lastTimeStamp! >= receiveFromSocketChat.first!.date {
            receiveFromSocketChat.removeFirst()
        }
        //소켓으로 떨어진 채팅 처리 시작
        mergeChatFromSocketFlag = true
        arrangeChat()
    }
    func arrangeChat() {
        var arragedChatList: [Chat] = []
        while mergeChatFromSocketFlag
                && !receiveFromSocketChat.isEmpty{
            arragedChatList.append(receiveFromSocketChat.first!)
            receiveFromSocketChat.removeFirst()
        }
        if !arragedChatList.isEmpty {
            presenter?.arrangedChatFromChat(chat: arragedChatList)
        }
    }
}
