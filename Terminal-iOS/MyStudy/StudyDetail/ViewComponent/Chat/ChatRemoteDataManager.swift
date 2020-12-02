//
//  ChatRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SocketIO

class ChatRemoteDataManager: ChatRemoteDataManagerProtocol {
    lazy var manager = SocketManager(socketURL: URL(string: "http://3.35.154.27:3000")!, config: [.log(false), .compress, .connectParams(["token": Terminal.tempToken, "study_id":1])])
    var chatSocket: SocketIOClient!
    
    init() {
        
    }
    
    func emit(message: String) {
        print("쏘는거",message)
        chatSocket.emit("chat", message)
    }
    
    func connectSocket() {
        chatSocket = manager.defaultSocket
        chatSocket.connect()
        
        chatSocket.on("message") { array, ack in
            print(array)
        }
    }
    func disconnectSocket() {
        chatSocket.disconnect()
    }
}
