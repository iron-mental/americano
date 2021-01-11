//
//  MyApplyStudyDetailWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class MyApplyStudyDetailWireFrame: MyApplyStudyDetailWireFrameProtocol {
    static func createMyApplyStudyDetailModule(studyID: Int) -> UIViewController {
        let view = MyApplyStudyDetailView()
        let interactor = MyApplyStudyDetailInteractor()
        let presenter = MyApplyStudyDetailPresenter()
        let remoteDataManager = MyApplyStudyDetailRemoteDataManager()
        let wireFrame = MyApplyStudyDetailWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        remoteDataManager.interactor = interactor
        
        return view
    }
}
