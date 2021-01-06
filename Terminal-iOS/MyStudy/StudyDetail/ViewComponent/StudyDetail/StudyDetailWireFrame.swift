//
//  StudyDetailWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyDetailWireFrame: StudyDetailWireFrameProtocol {
    static func createStudyDetail(parent: MyStudyDetailViewProtocol?, studyID: Int, state: StudyDetailViewState) -> UIViewController {
        
        let view: StudyDetailViewProtocol = StudyDetailView()
        let presenter: StudyDetailPresenterProtocol & StudyDetailInteractorOutputProtocol = StudyDetailPresenter()
        let interactor: StudyDetailInteractorInputProtocol & StudyDetailRemoteDataManagerOutputProtocol = StudyDetailInteractor()
        let remoteDataManager:StudyDetailRemoteDataManagerInputProtocol = StudyDetailRemoteManager()
        let wireFrame: StudyDetailWireFrameProtocol = StudyDetailWireFrame()
        
        view.presenter = presenter
        view.state = state
        view.parentView = parent
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        if let view = view as? StudyDetailView {
            view.studyID = studyID
            view.hidesBottomBarWhenPushed = true
            return view
        } else {
            return UIViewController()
        }

    }
    
    func presentStudyListScreen(from view: StudyDetailViewProtocol) {
        
    }
    
    func goToSelectCategory(from view: StudyDetailViewProtocol, category: [Category]) {
        
    }
}
