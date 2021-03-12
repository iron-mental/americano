//
//  ChatViewProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol ChatViewProtocol: class {
    var presenter: ChatPresenterProtocol? { get set }
    
    //PRESENTER -> VIEW
    func viewLoad() 
    func showLastChat(lastChat: [Chat])
    func showSocketChat(socketChat: Chat)
    func showMessage(message: String)
    func showLoading()
    func hideLoading()
    func showError(message: String)
}

protocol ChatInteractorProtocol: class {
    var presenter: ChatPresenterProtocol? { get set }
    var remoteDataManager: ChatRemoteDataManagerProtocol? { get set }
    var localDataManager: ChatLocalDataManagerProtocol? { get set }
    var studyID: Int? { get set }
    
    //PRESENTER -> INTERACTOR
    func connectSocket()
    func emit(message: String)
    func disconnectSocket()
    func mergeChatFromSocket()
    
    //remoteDataManager -> Interactor
    func receiveMessage(message: Chat)
    func receiveLastChat(lastRemoteChat: BaseResponse<[Chat]>)
    func sessionTaskError(message: String)
}

protocol ChatPresenterProtocol: class {
    var view: ChatViewProtocol? { get set }
    var wireFrame: ChatWireFrameProtocol? { get set }
    var interactor: ChatInteractorProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func viewRoadLastChat()
    func emitButtonDidTap(message: String)
    func viewWillDisappear()
    
    //INTERACTOR -> PRESENTER
    func showReceiveMessage(message: String)
    func getLastChatResult(lastChat: [Chat])
    func arrangedChatFromChat(chat: Chat)
    func showError(message: String)
}

protocol ChatRemoteDataManagerProtocol: class {
    var interactor: ChatInteractorProtocol? { get set }
    func socketConnect(studyID: Int, date: Int?)
    func emit(message: String)
    func disconnectSocket()
    func getRemoteChat(studyID: Int, date: Int?)
}

protocol ChatLocalDataManagerProtocol: class {
    
}

protocol ChatWireFrameProtocol: class {
    var presenter: ChatPresenterProtocol? { get set }
    static func createChatModule(studyID: Int) -> UIViewController
}
