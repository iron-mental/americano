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
        let view: ProfileDetailViewProtocol = ProfileDetailView()
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

        remoteManager.remoteRequestHandler = interactor
        
        if let view = view as? ProfileDetailView {
            view.hidesBottomBarWhenPushed = true
            return view
        } else {
            return UIViewController()
        }
    }
    
    func presentProfileModifyScreen(from view: ProfileDetailViewProtocol, userInfo: UserInfo, project: [Project]) {
        let profileModifyView = ProfileModifyWireFrame.createProfileModifyModule(userInfo: userInfo, project: project)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(profileModifyView, animated: true)
        }
    }
}
