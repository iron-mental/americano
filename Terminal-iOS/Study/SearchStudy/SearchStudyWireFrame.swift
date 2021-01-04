//
//  SearchStudyWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SearchStudyWireFrame: SearchStudyWireFrameProtocol {
    var presenter: SearchStudyPresenterProtocol?
    
    func goToSearchStudyRestult(keyWord: String) {
        let view = SearchStudyResultWireFrame.createSearchStudyResultModule()
        var searchView = (view as! SearchStudyResultViewProtocol)
        searchView.keyWord = keyWord
        (presenter?.view as! UIViewController).navigationController?.pushViewController(searchView as! UIViewController, animated: true)
    }
    
    static func createSearchStudyModule() -> UIViewController {
        let view = SearchStudyView()
        let interactor = SearchStudyInteractor()
        let presenter = SearchStudyPresenter()
        let remoteDataManager = SearchStudyRemoteDataManager()
        let localDataManager = SearchStudyLocalDataManager()
        let wireFrame = SearchStudyWireFrame()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        wireFrame.presenter = presenter
        
        return view
    }
}
