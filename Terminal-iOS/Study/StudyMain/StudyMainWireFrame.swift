//
//  StudyMainWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyMainWireFrame: StudyMainWireFrameProtocol {
    
    
    static func createStudyMainModule() -> UIViewController {
        let view = StudyMainView()
        let presenter: StudyMainPresenterProtocol = StudyMainPresenter()
        let interactor: StudyMainInteractorProtocol = StudyMainInteractor()
        let localDataManager: StudyMainLocalDataManagerProtocol = StudyMainLocalDataManager()
        let remoteDataManager: StudyMainRemoteDataManagerProtocol = StudyMainRemoteDataManager()
        let wireFrame: StudyMainWireFrameProtocol = StudyMainWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.localDataManager = localDataManager
        interactor.remoteDataManager = remoteDataManager
        
        return view
    }
    
    func goToSelectCategory(from view: StudyMainViewProtocol, category: String) {
        let selectCategoryView = SelectCategoryWireFrame.createSelectCategoryViewModul(category: category)
        
        if let sourceView = view as? UIViewController {
           sourceView.navigationController?.pushViewController(selectCategoryView, animated: false)
        }
    }
    func goToCreateStudy() {
        
    }
}
