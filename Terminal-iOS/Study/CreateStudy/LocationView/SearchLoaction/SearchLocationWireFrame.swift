//
//  SearchLocationWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SearchLocationWireFrame: SearchLocationWireFrameProtocol {
    static func searchLocationViewModule(parentView: UIViewController) -> UIViewController {
        let view = SearchLocationView()
        let interactor = SearchLocationInteractor()
        let presenter = SearchLocationPresenter()
        let remoteDataManager = SearchLocationRemoteDataManager()
        let wireFrame = SearchLocationWireFrame()
        
        view.presenter = presenter
        view.parentView = parentView
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.remoteDataManager = remoteDataManager
        interactor.presenter = presenter
        
        remoteDataManager.interactor

        return view
    }
    
    func goToSelectLocationView(item: StudyDetailLocationPost, view: UIViewController, parentView: UIViewController) {
        let selectLocationView = SelectLocationWireFrame.selectLocationViewModule(item: item, parentView: parentView)
        selectLocationView.modalPresentationStyle = .fullScreen
        view.present(selectLocationView, animated: false)
    }
}
