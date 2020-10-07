//
//  SetViewWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class SetViewWireFrame: SetViewWireFrameProtocol {
    static func createModule() -> UIViewController {
        let view = SetView()
        let presenter: SetViewPresenterProtocol & SetViewInteractorOutputProtocol = SetViewPresenter()
        let interactor: SetViewInteractortInputProtocol & SetViewRemoteDataManagerOutputProtocol = SetViewInteractor()
        
        let wireFrame: SetViewWireFrameProtocol = SetViewWireFrame()
    }
    
    func presentMenuDetailScreen(from view: SetViewProtocol) {
        
    }
    
    
}
