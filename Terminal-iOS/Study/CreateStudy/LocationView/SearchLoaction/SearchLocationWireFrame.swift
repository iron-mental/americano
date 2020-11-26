//
//  SearchLocationWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SearchLocationWireFrame: SearchLocationWireFrameProtocol {
    var presenter: SearchLocationPresenterProtocol?
    
    func goToSelectLocationView(item: StudyDetailLocationPost, view: UIViewController) {
        let selectLocationView = SelectLocationWireFrame.selectLocationViewModul(item: item)
        
        selectLocationView.modalPresentationStyle = .fullScreen
        view.present(selectLocationView, animated: false)
    }
    
    static func searchLocationViewModul() -> UIViewController {
        let view = SearchLocationView()
        let interactor = SearchLocationInteractor()
        let presenter = SearchLocationPresenter()
        let remoteDataManager = SearchLocationRemoteDataManager()
        let wireFrame = SearchLocationWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.remoteDataManager = remoteDataManager
        interactor.presenter = presenter

        return view
    }
}
