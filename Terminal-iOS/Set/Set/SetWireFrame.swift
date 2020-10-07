//
//  SetWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/07.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SetWireFrame: SetWireFrameProtocol {
    static func createModule() -> UIViewController {
        let view = SetView()
        let presenter: SetPresenterProtocol & SetInteractorOutputProtocol = SetPresenter()
        let interactor: SetInteractortInputProtocol & SetRemoteDataManagerOutputProtocol = SetInteractor()
        
        let wireFrame: SetWireFrameProtocol = SetWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        if let view = view as? SetView {
            return view
        } else {
            return UIViewController()
        }
    }
    
    func presentMenuDetailScreen(from view: SetViewProtocol) {
        
    }
    
    
}
