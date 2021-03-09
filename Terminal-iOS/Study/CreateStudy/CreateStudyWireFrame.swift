//
//  CreateStudyWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class CreateStudyWireFrame: CreateStudyWireFrameProtocol {
    static func createStudyViewModule(category: String,
                                      studyDetail: StudyDetail?,
                                      parentView: UIViewController?) -> UIViewController {
        
        let view = CreateStudyView()
        let presenter: CreateStudyPresenterProtocol & CreateStudyInteractorOutputProtocol = CreateStudyPresenter()
        let interactor: CreateStudyInteractorInputProtocol & CreateStudyReMoteDataManagerOutputProtocol = CreateStudyInteractor()
        let remoteDataManager = CreateStudyRemoteManager()
        let wireFrame = CreateStudyWireFrame()
        
        view.presenter = presenter
        view.selectedCategory = category
        
        view.study = studyDetail ?? nil
        view.parentView = parentView ?? nil
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.studyInfo = studyDetail ?? nil
        
        remoteDataManager.interactor = interactor
        
        return view
    }
    
    func goToSelectLocation(from view: CreateStudyViewProtocol) {
        if let sourceView = view as? UIViewController {
            let searchLocationview = SearchLocationWireFrame.searchLocationViewModule(parentView: sourceView)
            searchLocationview.modalPresentationStyle = .fullScreen
            sourceView.present(searchLocationview, animated: true, completion: nil)
        }
    }
}
