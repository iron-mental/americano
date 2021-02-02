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
    
    lazy var manager = SocketManager(socketURL: URL(string: "http://3.35.154.27:3000")!, 
                                     config: [ .log(false), .compress, .forceWebsockets(true),
                                               .connectParams(["token": KeychainWrapper.standard.string(forKey: "accessToken"), "study_id": 231])])
    var chatSocket: SocketIOClient!
    
    init() {
        
    }
    
    func emit(message: String) {
        chatSocket.emit("chat", message)
    }
    
    func connectSocket() {
        chatSocket = manager.socket(forNamespace: "/terminal")
        chatSocket.connect()
        chatSocket.on("message") { array, ack in
            self.interactor?.receiveMessage(message: "\(array)")
        }
    }
    func disconnectSocket() {
        chatSocket.disconnect()
    }
}
