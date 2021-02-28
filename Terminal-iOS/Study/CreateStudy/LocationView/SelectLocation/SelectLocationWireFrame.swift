//
//  SelectLocationWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectLocationWireFrame: SelectLocationWireFrameProtocol {    
    static func selectLocationViewModule(item: StudyDetailLocationPost, parentView: UIViewController) -> UIViewController {
        let view = SelectLocationView()
        view.location = item
        view.delegate = parentView as? selectLocationDelegate
        
        let interactor = SelectLocationInteractor()
        let presenter = SelectLocationPresenter()
        let remoteDataManager = SelectLocationRemoteDataManager()
        let localDataManager = SelectLocationLocalDataManager()
        let wireFrame = SelectLocationWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.localDataManager = localDataManager
        interactor.remoteDataManager = remoteDataManager
        
        return view
    }
}
