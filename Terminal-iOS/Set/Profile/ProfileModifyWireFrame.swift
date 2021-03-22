//
//  ProfileModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class ProfileModifyWireFrame: ProfileModifyWireFrameProtocol {
    static func createProfileModifyModule(profile: Profile) -> UIViewController {
        let view: ProfileModifyViewProtocol = ProfileModifyView()
        let presenter: ProfileModifyPresenterProtocol & ProfileModifyInteractorOutputProtocol = ProfileModifyPresenter()
        let interactor: ProfileModifyInteractorInputProtocol & ProfileModifyRemoteDataManagerOutputProtocol = ProfileModifyInteractor()
        let remoteDataManager: ProfileModifyRemoteDataManagerInputProtocol = ProfileModifyRemoteManager()
        let wireFrame: ProfileModifyWireFrameProtocol = ProfileModifyWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        if let view = view as? ProfileModifyView {
            view.profile = profile
            return view
        } else {
            return UIViewController()
        }
    }
}
