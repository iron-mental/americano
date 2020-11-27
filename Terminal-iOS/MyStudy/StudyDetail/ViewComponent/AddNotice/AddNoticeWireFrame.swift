//
//  AddNoticeWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class AddNoticeWireFrame: AddNoticeWireFrameProtocol {
    var presenter: AddNoticePresenterProtocol?
    
    static func createAddNoticeModule(studyID: Int) -> UIViewController {
        let view = AddNoticeView()
        let presenter = AddNoticePresenter()
        let interactor = AddNoticeInteractor()
        let remoteDataManager = AddNoticeRemoteDataManager()
        let localDataManager = AddNoticeLocalDataManager()
        let wireFrame = AddNoticeWireFrame()
        
        view.presenter = presenter
        view.studyID = studyID
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