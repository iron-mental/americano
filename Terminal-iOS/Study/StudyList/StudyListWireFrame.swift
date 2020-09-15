//
//  StudyListWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyListWireFrame: StudyListWireFrameProtocol {
    static func createStudyListModule() -> UIViewController {
        let view: StudyListViewProtocol = StudyListView()
        let presenter: StudyListPresenterProtocol & StudyListInteractorOutputProtocol = StudyListPresenter()
        let interactor: StudyListInteractorInputProtocol & StudyListRemoteDataManagerOutputProtocol = StudyListInteractor()
        let remoteDataManager: StudyListRemoteDataManagerInputProtocol = StudyListRemoteDataManager()
        let localDataManager: StudyListLocalDataManagerInputProtocol = StudyListLocalDataManager()
        let wireFrame: StudyListWireFrameProtocol = StudyListWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        if let view = view as? StudyListView {
            return UINavigationController(rootViewController: view)
        } else {
            return UIViewController()
        }

    }
    
    func presentStudyDetailScreen(from view: StudyListViewProtocol, forStudy study: Study) {
        
    }
}
