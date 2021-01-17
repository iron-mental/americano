//
//  EmailAuthWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class EmailAuthWireFrame: EmailAuthWireFrameProtocol {
    static func createModule() -> UIViewController {
        let view: EmailAuthViewProtocol = EmailAuthView()
        let presenter: EmailAuthPresenterProtocol & EmailAuthInteractorOutputProtocol = EmailAuthPresenter()
        let interactor: EmailAuthInteractorInputProtocol = EmailAuthInteractor()
        let wireFrame: EmailAuthWireFrameProtocol = EmailAuthWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireFrame
        interactor.presenter = presenter
        
        
        if let view = view as? EmailAuthView {
            return view
        } else {
            return UIViewController()
        }
    }
}
