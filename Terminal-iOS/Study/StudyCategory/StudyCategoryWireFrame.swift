//
//  StudyCategoryWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyCategoryWireFrame: StudyCategoryWireFrameProtocol {
    static func createStudyCategory() -> UIViewController {
        let view = StudyCategoryView()
        let presenter: StudyCategoryPresenterProtocol & StudyCategoryInteractorOutputProtocol = StudyCategoryPresenter()
        let interactor: StudyCategoryInteractorInputProtocol & StudyCategoryRemoteDataManagerOutputProtocol = StudyCategoryInteractor()
        let localDataManager: StudyCategoryLocalDataManagerInputProtocol = StudyCategoryLocalDataManager()
        let remoteDataManager: StudyCategoryRemoteDataManagerInputProtocol = StudyCategoryRemoteManager()
        let wireFrame: StudyCategoryWireFrameProtocol = StudyCategoryWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        
        remoteDataManager.remoteRequestHandler = interactor
        
        if let view = view as? StudyCategoryView {
            return view
        } else {
            return UIViewController()
        }
    }
    
    func presentStudyListScreen(from view: StudyCategoryViewProtocol) {
        let studyListViewController = StudyListWireFrame.createStudyListModule()
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(studyListViewController, animated: true)
        }
    }
    
    func goToSelectCategory(from view: StudyCategoryViewProtocol, category: [Category]) {
        let selectCategoryView = SelectCategoryWireFrame.createSelectCategoryViewModul(category: category)
        
        if let sourceView = view as? UIViewController {
           sourceView.navigationController?.pushViewController(selectCategoryView, animated: false)
        }
    }
}
