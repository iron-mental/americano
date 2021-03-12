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
        chatSocket.manager?.engine?.ws?.disableSSLCertValidation = true
        chatSocket.manager?.engine?.sid
//        chatSocket.manager?.engine?.ws?.
        chatSocket.emit("chat", message)
    }
    
    func socketConnect(studyID: Int) {
//        guard let baseURL = URL(string: "https://www.terminal-study.tk/terminal"),
              guard let baseURL = URL(string: "https://www.terminal-study.tk"),
              let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") else { return }
        manager = SocketManager(socketURL: baseURL,
                                config: [.log(true),
                                         .compress,
                                         .forceWebsockets(true),
                                         .connectParams(["token": accessToken,
                                                         "study_id": studyID])])
        
        chatSocket = manager!.socket(forNamespace: "/terminal")
//        chatSocket = manager!.defaultSocket
        
        chatSocket.connect()
        chatSocket.on("message") { array, ack in
            print("왔다",array)
//            self.interactoar?.receiveMessage(message: chat)
        }
        //        connect 이벤트에서 getRemoteChat() 호출
        chatSocket.on("connect") { array, ack in
            print(array)
            getRemoteChat()
        }
    }
    
    func disconnectSocket() {
        //        chatSocket.disconnect()
    }
    
    func getRemoteChat() {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter)
        interactor?.receiveLastChat(lastRemoteChat: [])
    }
}
