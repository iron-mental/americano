//
//  SNSModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//
import UIKit

class SNSModifyWireFrame: SNSModifyWireFrameProtocol {
    static func createModule() -> UIViewController {
        let view: SNSModifyViewProtocol = SNSModifyView()
        let presenter: SNSModifyPresenterProtocol & SNSModifyInteractorOutputProtocol = SNSModifyPresenter()
        let interactor: SNSModifyInteractorInputProtocol = SNSModifyInteractor()
        let wireFrame: SNSModifyWireFrameProtocol = SNSModifyWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
       
        if let view = view as? SNSModifyView {
            return view
        } else {
            return UIViewController()
        }
    }
    
    func presentProfileModifyScreen(from view: SNSModifyViewProtocol, userInfo: UserInfo, project: [Project]) {
        
    }
}
