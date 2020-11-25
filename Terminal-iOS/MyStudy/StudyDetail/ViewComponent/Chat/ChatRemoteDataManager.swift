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
    lazy var manager = SocketManager(socketURL: URL(string: "http://3.35.154.27:3000/v1/chat")!, config: [.log(false), .compress, .connectParams(["token": Terminal.tempToken, "room":10])])
    var chatSocket: SocketIOClient!
    
    init() {
        chatSocket = manager.socket(forNamespace: "/android")
        chatSocket.connect()
        chatSocket.on("message") { [self] (array, ack) in
            
            //여기서 바로 인터렉터로 넘겨줘야겠죠?

//            JSON(array).array?.forEach {
//                receiveLabel.text = $0.string!
//                print("이거 제깍제깍오면 내잘못",$0)
//            }
            

        }
        
    }
    func emit(_ message: String) {
        chatSocket.emit("chat", message)
    }
    
}
