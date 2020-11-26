//
//  ProfileModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileDetailWireFrame: ProfileDetailWireFrameProtocol {
    static func createModule() -> UIViewController {
        let view = ProfileDetailView()
        let presenter: ProfileDetailPresenterProtocol & ProfileDetailInteractorOutputProtocol = ProfileDetailPresenter()
        let interactor: ProfileDetailInteractorInputProtocol & ProfileDetailRemoteDataManagerOutputProtocol = ProfileDetailInteractor()
        let wireFrame: ProfileDetailWireFrameProtocol = ProfileDetailWireFrame()
        let remoteManager: ProfileDetailRemoteDataManagerInputProtocol = ProfileDetailRemoteManager()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteManager
//        if let view = view as? ProfileDetailView {
        return view
//        } else {
//            return UIViewController()
//        }
    }
}
