//
//  ModifyStudyWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ModifyStudyWireFrame: ModifyStudyWireFrameProtocol {
    static func createModifyStudyModule(study: StudyDetail) -> UIViewController {
        let view = ModifyStudyView()
        let presenter: ModifyStudyPresenterProtocol & ModifyStudyInteractorOutputProtocol = ModifyStudyPresenter()
        let interactor: ModifyStudyInteractorInputProtocol & ModifyStudyRemoteDataManagerOutputProtocol = ModifyStudyInteractor()
        let remoteDataManager: ModifyStudyRemoteDataManagerInputProtocol = ModifyStudyRemoteDataManager()
        let wireFrame = ModifyStudyWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        remoteDataManager.interactor = interactor
        view.study = study
        interactor.currentStudy = study
        
        return view
    }
    
    func goToSelectLocation(from view: ModifyStudyViewProtocol) {
        if let sourceView = view as? UIViewController {
            let searchLocationview = SearchLocationWireFrame.searchLocationViewModule(parentView: sourceView)
            searchLocationview.modalPresentationStyle = .fullScreen
            sourceView.present(searchLocationview, animated: true, completion: nil)
        }
    }
}
