//
//  ProfileModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileModifyWireFrame: ProfileModifyWireFrameProtocol {
    static func createProfileModifyModule(userInfo: UserInfo, project: [Project]) -> UIViewController {
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
            view.projectArr = project
            return view
        } else {
            return UIViewController()
        }
    }
    func removeParentProfileModify(from view: ProfileModifyViewProtocol) {
        if let sourceView = view as? UIViewController {
            sourceView.willMove(toParent: nil)
            // Remove Constraint.
            // 제약사항 제거
            sourceView.view.removeFromSuperview()
            // Remove the relationship of the child connected to the parent.
            // 부모에 연결된 자식의 관계를 제거합니다.
            sourceView.removeFromParent()
        }
    }
}
