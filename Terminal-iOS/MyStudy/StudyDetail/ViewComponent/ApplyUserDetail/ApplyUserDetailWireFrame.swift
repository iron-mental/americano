//
//  ApplyUserDetailWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/15.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ApplyUserDetailWireFrame: ApplyUserDetailWireFrameProtocol {
    static func createApplyUserDetailModule(userInfo: ApplyUser, studyID: Int) -> UIViewController {
        var view: ApplyUserDetailViewProtocol = ApplyUserDetailView()
        var presenter: ApplyUserDetailPresenterInputProtocol & ApplyUserDetailInteractorOutputProtocol = ApplyUserDetailPresenter()
        var interactor: ApplyUserDetailInteractorInputProtocol & ApplyUserDetailRemoteDataManagerOutputProtocol = ApplyUserDetailInteractor()
        let remoteDataManager = ApplyUserDetailRemoteDataManager()
        let wireFrame = ApplyUserDetailWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        remoteDataManager.remoteRequestHandler = interactor
        
        interactor.applyID = userInfo.id
        interactor.studyID = studyID
        interactor.userID = userInfo.userID
        return view as! UIViewController
    }
}
