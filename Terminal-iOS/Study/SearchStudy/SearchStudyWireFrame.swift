//
//  SearchStudyWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class SearchStudyWireFrame: SearchStudyWireFrameProtocol {
    static func createSearchStudyModule() -> UIViewController {
        let view = SearchStudyView()
        let interactor: SearchStudyInteractorInputProtocol & SearchStudyRemoteDataManagerOutputProtocol = SearchStudyInteractor()
        let presenter: SearchStudyPresenterProtocol & SearchStudyInteractorOutputProtocol = SearchStudyPresenter()
        let remoteDataManager = SearchStudyRemoteDataManager()
        let wireFrame = SearchStudyWireFrame()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        remoteDataManager.interactor = interactor
        
        return view
    }
    
    func goToSearchStudyRestult(from view: SearchStudyViewProtocol, keyword: String) {
        let searchView = SearchStudyResultWireFrame.createSearchStudyResultModule(keyword: keyword)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(searchView, animated: true)
        }
    }
   
}
