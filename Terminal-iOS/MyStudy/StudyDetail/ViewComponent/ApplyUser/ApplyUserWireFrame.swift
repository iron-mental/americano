//
//  ApplyUserWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ApplyUserWireFrame: ApplyUserWireFrameProtocol {
    static func createUserListModule(studyID: Int) -> UIViewController {
        let view: ApplyUserViewProtocol = ApplyUserView()
        let presenter: ApplyUserPresenterProtocol & ApplyUserInteractorOutputProtocol = ApplyUserPresenter()
        let interactor: ApplyUserInteractorInputProtocol = ApplyUserInteractor()
        let wireFrame: ApplyUserWireFrameProtocol = ApplyUserWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        if let view = view as? ApplyUserView {
            view.studyID = studyID
            return view
        } else {
            return UIViewController()
        }
    }
    
    func presentUserInfoDetailScreen(from view: ApplyUserViewProtocol, userID: Int) {
        let userDetailView = ApplyUserDetailView()
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(userDetailView, animated: true)
        }
    }
}
