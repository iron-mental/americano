//
//  StudyDetailWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/17.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyDetailWireFrame: StudyDetailWireFrameProtocol {
    static func createStudyDetailViewModul(study: MyStudy) -> UIViewController {
        
        let studyDetailView = StudyDetailView()
        
        let studyDetailViewControllerView = StudyDetailViewController()
        let studyDetailViewControllerPresenter = StudyDetailViewControllerPresenter()
        let studyDetailViewControllerInteractor = StudyDetailViewControllerInteractor()
        let studyDetailViewControllerRemoteDataManager = StudyDetailViewControllerRemoteDataManager()
        let studyDetailViewControllerLocalDataManager = StudyDetailViewControllerLocalDataManager()
        let studyDetailViewControllerWireFrame = StudyDetailViewControllerWireFrame()
        
        studyDetailViewControllerView.presenter = studyDetailViewControllerPresenter
        
        studyDetailViewControllerPresenter.view = studyDetailViewControllerView
        studyDetailViewControllerPresenter.interactor = studyDetailViewControllerInteractor
        studyDetailViewControllerPresenter.wireFrame = studyDetailViewControllerWireFrame
        
        studyDetailViewControllerInteractor.presenter = studyDetailViewControllerPresenter
        studyDetailViewControllerInteractor.remoteDataManager = studyDetailViewControllerRemoteDataManager
        studyDetailViewControllerInteractor.localDataManager = studyDetailViewControllerLocalDataManager
        
        studyDetailViewControllerWireFrame.presenter = studyDetailViewControllerPresenter
        
        
        studyDetailViewControllerView.studyInfo = study
        studyDetailView.VCArr[1] = studyDetailViewControllerView
        studyDetailView.hidesBottomBarWhenPushed = true
        
//        (view.VCArr[1] as! StudyDetailViewControllerViewProtocol).studyInfo = study
        return studyDetailView
    }
}
