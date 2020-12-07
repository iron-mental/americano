//
//  ChatWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ChatWireFrame: ChatWireFrameProtocol {
    var presenter: ChatPresenterProtocol?
    
    static func createChatModule() -> UIViewController {
        let view = TempChatView()
        let presenter = ChatPresenter()
        let interactor = ChatInteractor()
        let remoteDataManager = ChatRemoteDataManager()
        let localDataManager = ChatLocalDataManager()
        let wireFrame = ChatWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        
        wireFrame.presenter = presenter
        
        return view
    }
}
