//
//  ChatViewProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol ChatViewProtocol: UIViewController {
    var presenter: ChatPresenterProtocol? { get set }
    
    //PRESENTER -> VIEW
    func showMessage(message: String)
}

protocol ChatInteractorProtocol: class {
    var presenter: ChatPresenterProtocol? { get set }
    var remoteDataManager: ChatRemoteDataManagerProtocol? { get set }
    var localDataManager: ChatLocalDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func connectSocket()
    func emit(message: String)
    func disconnectSocket()
    
    //remoteDataManager -> Interactor
    func receiveMessage(message: String)
}

protocol ChatPresenterProtocol: class {
    var view: ChatViewProtocol? { get set }
    var wireFrame: ChatWireFrameProtocol? { get set }
    var interactor: ChatInteractorProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func emitButtonDidTap(message: String)
    func viewWillDisappear()
    
    //INTERACTOR -> PRESENTER
    func showReceiveMessage(message: String)
}

protocol ChatRemoteDataManagerProtocol: class {
    var interactor: ChatInteractorProtocol? { get set }
    func connectSocket()
    func emit(message: String)
    func disconnectSocket()
}

protocol ChatLocalDataManagerProtocol: class {
    
}

protocol ChatWireFrameProtocol: class {
    var presenter: ChatPresenterProtocol? { get set }
    static func createChatModule(studyID: Int) -> UIViewController
}
