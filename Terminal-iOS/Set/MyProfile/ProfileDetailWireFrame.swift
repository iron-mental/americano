//
//  ProfileModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class ProfileDetailWireFrame: ProfileDetailWireFrameProtocol {
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
    
    func presentEmailModify(from view: ProfileDetailViewProtocol, email: String) {
        let emailModifyView = EmailModifyWireFrame.createModule(email: email)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(emailModifyView, animated: true)
        }
    }
    
    func presentSNSModify(from view: ProfileDetailViewProtocol,
                          github: String,
                          linkedin: String,
                          web: String) {
        let snsModifyView = SNSModifyWireFrame.createModule(github: github, linkedin: linkedin, web: web)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(snsModifyView, animated: true)
        }
    }
    
    func presentProfileModify(from view: ProfileDetailViewProtocol, profile: Profile) {
        let profileModifyView = ProfileModifyWireFrame.createProfileModifyModule(profile: profile)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(profileModifyView, animated: true)
        }
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

    func presentProjectModify(from view: ProfileDetailViewProtocol, project: [Project]) {
        let projectModifyView = ProjectModifyWireFrame.createModule(project: project)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(projectModifyView, animated: true)
        }
    }
}
