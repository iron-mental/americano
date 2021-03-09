//
//  MyApplyStudyModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
class MyApplyStudyModifyWireFrame: MyApplyStudyModifyWireFrameProtocol {
    
    static func createMyApplyStudyModifyModule(parentView: UIViewController, studyID: Int) -> UIViewController {
        let view = MyApplyStudyModifyView()
        let interactor = MyApplyStudyModifyInteractor()
        let presenter = MyApplyStudyModifyPresenter()
        let remoteDataManager = MyApplyStudyModifyRemoteDataManager()
        let wireFrame = MyApplyStudyModifyWireFrame()
        
        view.presenter = presenter
        view.studyID = studyID
        view.parentView = parentView
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        remoteDataManager.interactor = interactor
        
        return view
    }
}
