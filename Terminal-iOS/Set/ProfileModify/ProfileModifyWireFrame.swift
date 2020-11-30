//
//  ProfileModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileModifyWireFrame: ProfileModifyWireFrameProtocol {
    static func createProfileModifyModule(userInfo: UserInfo) -> UIViewController {
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
            view.userInfo = userInfo
            return view
        } else {
            return UIViewController()
        }
    }
}
