//
//  ChatRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SocketIO
import SwiftKeychainWrapper

class ChatRemoteDataManager: ChatRemoteDataManagerProtocol {
    weak var interactor: ChatInteractorProtocol?
    var chatSocket: SocketIOClient!
    var manager: SocketManager?
    
    func emit(message: String) {
//        chatSocket.emit("chat", message)
    }
    
    func socketConnect(studyID: Int) {
        guard let baseURL = URL(string: "http://www.terminal-study.tk/terminal"),
              let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") else { return }
        manager = SocketManager(socketURL: baseURL,
                                config: [.log(true),
                                         .compress,
                                         .secure(true),
                                         .forceWebsockets(true),
                                         .connectParams(["token": accessToken,
                                                         "study_id": studyID])])
        chatSocket = manager!.defaultSocket
        chatSocket.connect()
        chatSocket.on("message") { array, ack in
            let chat = Chat(studyID: 1, nickname: "S", message: "S", date: 0)
            self.interactor?.receiveMessage(message: chat)
        }
//        connect 이벤트에서 getRemoteChat() 호출
    }
    
    func disconnectSocket() {
//        chatSocket.disconnect()
    }
    
    func getRemoteChat() {
//        getChat API 콜 후
        interactor?.receiveLastChat(lastRemoteChat: [])
    }
}
