//
//  ModifyStudyWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ModifyStudyWireFrame: ModifyStudyWireFrameProtocol {
    static func createModifyStudyModule(study: StudyDetail, parentView: UIViewController) -> UIViewController {
        let view = ModifyStudyView()
        let presenter: ModifyStudyPresenterProtocol & ModifyStudyInteractorOutputProtocol = ModifyStudyPresenter()
        let interactor: ModifyStudyInteractorInputProtocol & ModifyStudyRemoteDataManagerOutputProtocol = ModifyStudyInteractor()
        let remoteDataManager: ModifyStudyRemoteDataManagerInputProtocol = ModifyStudyRemoteDataManager()
        let wireFrame = ModifyStudyWireFrame()
        
        view.presenter = presenter
        view.parentView = parentView
        
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
    func goToSelectLocation(view: UIViewController) {
        let searchLocationview =  SearchLocationWireFrame.searchLocationViewModule(parentView: view)
        //modal의 형태를 추후에 정하구요 dismiss 시켜주는 것 만으로 다시 원래 플로우인 스터디 생성 플로우로 돌아가게 하면 깔끔 할 것 같은 느낌
        searchLocationview.modalPresentationStyle = .fullScreen
        view.present(searchLocationview, animated: true, completion: nil)
    }
}
