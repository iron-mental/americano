//
//  AddNoticeWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class AddNoticeWireFrame: AddNoticeWireFrameProtocol {
    static func createAddNoticeModule(studyID: Int?, notice: Notice?, parentView: UIViewController, state: AddNoticeState) -> UIViewController {
        let view = AddNoticeView()
        let presenter = AddNoticePresenter()
        let interactor = AddNoticeInteractor()
        let remoteDataManager = AddNoticeRemoteDataManager()
        let localDataManager = AddNoticeLocalDataManager()
        let wireFrame = AddNoticeWireFrame()
        
        view.presenter = presenter
        view.studyID = studyID != nil ? studyID : nil
        view.state = state
        view.parentView = parentView
        view.notice = notice != nil ? notice : nil
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        
        return view
    }
    
    func goToNoticeDetailView(noticeID: Int, studyID: Int, parentView: UIViewController?) {
        
    }
}
