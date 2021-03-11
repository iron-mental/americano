//
//  MyApplyStudyDetailWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class MyApplyStudyInfoWireFrame: MyApplyStudyInfoWireFrameProtocol {
    static func createMyApplyStudyDetailModule(applyStudy: ApplyStudy) -> UIViewController {
        let view  = MyApplyStudyInfoView()
        let presenter: MyApplyStudyInfoPresenterProtocol & MyApplyStudyInfoInteractorOutputProtocol = MyApplyStudyInfoPresenter()
        let interactor: MyApplyStudyInfoInteractorInputProtocol & MyApplyStudyInfoRemoteDataManagerOutputProtocol = MyApplyStudyInfoInteractor()
        let remoteDataManager: MyApplyStudyInfoRemoteDataManagerInputProtocol  = MyApplyStudyInfoRemoteDataManager()
        let wireFrame = MyApplyStudyInfoWireFrame()
        
        view.applyStudy = applyStudy
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.applyID = applyStudy.id
        interactor.studyID = applyStudy.studyID
        
        remoteDataManager.interactor = interactor
        
        return view
    }
    
    func goToMyApplyStudyModify(from view: UIViewController, studyID: Int) {
        let myApplyStudyModifyView = MyApplyStudyModifyWireFrame.createMyApplyStudyModifyModule(parentView: view, studyID: studyID)
        view.present(myApplyStudyModifyView, animated: true, completion: nil)
    }
}
