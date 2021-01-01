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
    
    func presentEmailModify(from view: ProfileDetailViewProtocol) {
        let emailModifyView = EmailModifyWireFrame.createModule()
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(emailModifyView, animated: true)
        }
    }
    
    func presentSNSModify(from view: ProfileDetailViewProtocol) {
        let snsModifyView = SNSModifyWireFrame.createModule()
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(snsModifyView, animated: true)
        }
    }
    func presentProfileModify(from view: ProfileDetailViewProtocol) {
//        let profileModifyView = ProfileModifyWireFrame.createModule()
//        
//        if let sourceView = view as? UIViewController {
//            sourceView.navigationController?.pushViewController(profileModifyView, animated: true)
//        }
    }
    
    func presentLocationModify(from view: ProfileDetailViewProtocol) {
        let locationModifyView = LocationModifyWireFrame.createModule()
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(locationModifyView, animated: true)
        }
    }
    
    func presentCareerModify(from view: ProfileDetailViewProtocol, title: String, Contents: String) {
        let careerModifyView = CareerModifyWireFrame.createModule(title: title, contents: Contents)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(careerModifyView, animated: true)
        }
    }
    
    func presentProjectModify(from view: ProfileDetailViewProtocol) {
        let projectModifyView = ProjectModifyWireFrame.createModule()
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(projectModifyView, animated: true)
        }
    }
}
