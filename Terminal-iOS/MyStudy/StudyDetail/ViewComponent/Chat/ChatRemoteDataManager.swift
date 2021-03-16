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
import SwiftyJSON

class ChatRemoteDataManager: ChatRemoteDataManagerProtocol {
    weak var interactor: ChatInteractorProtocol?
    var chatSocket: SocketIOClient!
    var manager: SocketManager?
    
    func socketConnect(studyID: Int, date: Int? = nil) {
        guard let baseURL = URL(string: "https://www.terminal-study.tk"),
              let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") else { return }
        manager = SocketManager(socketURL: baseURL,
                                config: [.log(false),
                                         .compress,
                                         .forceWebsockets(true),
                                         .connectParams(["token": accessToken,
                                                         "study_id": studyID])])
        chatSocket = manager!.socket(forNamespace: "/terminal")
        chatSocket.connect()
        
        
        chatSocket.on("connect") { _, _ in
            self.getRemoteChat(studyID: studyID, date: date)
        }
        chatSocket.on("disconnect") {_, _ in
            print("끊어짐")
        }
        chatSocket.on("message") { array, _ in
            do {
                let json = JSON(array[0])
                if let data = "\(json)".data(using: .utf8) {
                    let newMessage = try JSONDecoder().decode(Chat.self, from: data)
                    self.interactor?.receiveMessage(message: newMessage)
                }
            } catch { }
        }
        chatSocket.on("update_user_list") { array, _ in
            do {
                let json = JSON(array)
                if let data = "\(json)".data(using: .utf8) {
                    let newList = try JSONDecoder().decode([ChatParticipate].self, from: data)
                    self.interactor?.setNicknameList(list: newList)
                }
            } catch {
                
            }
        }
        
        
    }
    
    func emit(message: [String: Any]) {
        chatSocket.emit("chat", message)
    }
    
    func disconnectSocket() {
        chatSocket.disconnect()
    }
    
    func getRemoteChat(studyID: Int, date: Int?) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyChat(studyID: studyID,
                                              date: date ?? 0,
                                              first: date == nil))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<RemoteChatInfo>.self, from: data)
                        if result.data?.chatList != nil {
                            self.interactor?.receiveLastChat(lastRemoteChat: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.interactor?.sessionTaskError(message:
                                                                TerminalNetworkManager
                                                                .shared
                                                                .sessionTaskErrorMessage)
                        default:
                            if let data = response.data {
                                do {
                                    let result = try JSONDecoder().decode(BaseResponse<RemoteChatInfo>.self, from: data)
                                    if result.message != nil {
                                        self.interactor?.receiveLastChat(lastRemoteChat: result)
                                    }
                                } catch {
                                    
                                }
                            }
                        }
                    }
                }
            }
    }
}
