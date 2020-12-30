//
//  ChatInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ChatInteractor: ChatInteractorProtocol {
    
    
    
    
    
    
    var presenter: ChatPresenterProtocol?
    var remoteDataManager: ChatRemoteDataManagerProtocol?
    var localDataManager: ChatLocalDataManagerProtocol?
    
    func connectSocket() {
        remoteDataManager?.connectSocket()
    }
    func emit(message: String) {
        remoteDataManager?.emit(message: message)
    }
    func disconnectSocket() {
        remoteDataManager?.disconnectSocket()
    }
    func receiveMessage(message: String) {
        presenter?.showReceiveMessage(message: message)
        // 대충 코어데이터에 넣어봅시다 ^^ 바른말고운말
    }
}
