//
//  SearchStudyResultWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/04.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class SearchStudyResultWireFrame: SearchStudyResultWireFrameProtocol {
    var presenter: SearchStudyResultPresenterProtocol?
    
    static func createSearchStudyResultModule() -> UIViewController{
        let view = SearchStudyResultView()
        let interactor = SearchStudyResultInteractor()
        let presenter = SearchStudyResultPresenter()
        let remoteDataManager = SearchStudyResultRemoteDataManager()
        let localDataManager = SearchStudyResultLocalDataManager()
        let wireFrame = SearchStudyResultWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        remoteDataManager.interactor = interactor
        wireFrame.presenter = presenter
        
        return view
    }
}
