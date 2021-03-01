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
        let view: ApplyUserDetailViewProtocol = ApplyUserDetailView()
        let presenter: ApplyUserDetailPresenterInputProtocol
            & ApplyUserDetailInteractorOutputProtocol = ApplyUserDetailPresenter()
        let interactor: ApplyUserDetailInteractorInputProtocol
            & ApplyUserDetailRemoteDataManagerOutputProtocol = ApplyUserDetailInteractor()
        let remoteDataManager = ApplyUserDetailRemoteDataManager()
        let wireFrame = ApplyUserDetailWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        remoteDataManager.interactor = interactor
        
        if let view = view as? UIViewController {
            interactor.applyID = userInfo.id
            interactor.studyID = studyID
            interactor.userID = userInfo.userID
            return view
        } else {
            return UIViewController()
        }
    }
}
