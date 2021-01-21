//
//  EmailModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class EmailModifyWireFrame: EmailModifyWireFrameProtocol {
    static func createModule(email: String) -> UIViewController {
        let view: EmailModifyViewProtocol = EmailModifyView()
        let presenter: EmailModifyPresenterProtocol & EmailModifyInteractorOutputProtocol = EmailModifyPresenter()
        let interactor: EmailModifyInteractorInputProtocol = EmailModifyInteractor()
        let wireFrame: EmailModifyWireFrameProtocol = EmailModifyWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
       
        if let view = view as? EmailModifyView {
            view.email = email
            return view
        } else {
            return UIViewController()
        }
    }
    
    func presentProfileModifyScreen(from view: EmailModifyViewProtocol, userInfo: UserInfo, project: [Project]) {
        
    }
}
