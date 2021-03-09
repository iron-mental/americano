//
//  LocationModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class LocationModifyWireFrame: LocationModifyWireFrameProtocol {
    static func createModule() -> UIViewController {
        let view: LocationModifyViewProtocol = LocationModifyView()
        let presenter: LocationModifyPresenterProtocol
            & LocationModifyInteractorOutputProtocol = LocationModifyPresenter()
        let interactor: LocationModifyInteractorInputProtocol
            & LocationModifyRemoteDataManagerOutputProtocol = LocationModifyInteractor()
        let wireFrame: LocationModifyWireFrameProtocol = LocationModifyWireFrame()
        let remoteDataManager: LocationModifyRemoteDataManagerInputProtocol = LocationModifyRemoteDataManager()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        remoteDataManager.remoteRequestHandler = interactor
        
        if let view = view as? LocationModifyView {
            return view
        } else {
            return UIViewController()
        }
    }
}
