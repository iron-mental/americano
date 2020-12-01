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
}

protocol ChatInteractorProtocol {
    var presenter: ChatPresenterProtocol? { get set }
    var remoteDataManager: ChatRemoteDataManagerProtocol? { get set }
    var localDataManager: ChatLocalDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func connectSocket()
    func emit(message: String)
    func disconnectSocket()
}

protocol ChatPresenterProtocol {
    var view: ChatViewProtocol? { get set }
    var wireFrame: ChatWireFrameProtocol? { get set }
    var interactor: ChatInteractorProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func emitButtonDidTap(message: String)
    func viewWillDisappear()
}

protocol ChatRemoteDataManagerProtocol {
    func connectSocket()
    func emit(message: String)
    func disconnectSocket()
}

protocol ChatLocalDataManagerProtocol {
    
}

protocol ChatWireFrameProtocol {
    var presenter: ChatPresenterProtocol? { get set }
    static func createChatModule() -> UIViewController
}
