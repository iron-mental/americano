//
//  ProfileModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileModifyWireFrame: ProfileModifyWireFrameProtocol {
    static func createModule() -> UIViewController {
        let view = ProfileModifyView()
        let presenter: ProfileModifyPresenterProtocol & ProfileModifyInteractorOutputProtocol = ProfileModifyPresenter()
        
        let interactor: ProfileModifyInteractorInputProtocol & ProfileModifyRemoteDataManagerOutputProtocol = ProfileModifyInteractor()
        
        let wireFrame: ProfileModifyWireFrameProtocol = ProfileModifyWireFrame()
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        if let view = view as? ProfileModifyView {
            return view
        } else {
            return UIViewController()
        }
    }
}
