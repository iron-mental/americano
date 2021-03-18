//
//  ChatWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class ChatWireFrame: ChatWireFrameProtocol {
    weak var presenter: ChatPresenterProtocol?
    
    static func createChatModule(studyID: Int) -> UIViewController {
        let view: ChatViewProtocol = ChatView()
        let presenter: ChatPresenterProtocol
            & ChatInteractorOutputProtocol = ChatPresenter()
        let interactor: ChatInteractorProtocol
            & ChatRemoteDataManagerOutputProtocol = ChatInteractor()
        let remoteDataManager: ChatRemoteDataManagerProtocol = ChatRemoteDataManager()
        let localDataManager: ChatLocalDataManagerProtocol = ChatLocalDataManager()
        let wireFrame: ChatWireFrameProtocol = ChatWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        interactor.studyID = studyID
        
        remoteDataManager.interactor = interactor
        
        wireFrame.presenter = presenter
        
        if let view = view as? UIViewController {
            return view
        } else {
            return UIViewController()
        }
    }
}
