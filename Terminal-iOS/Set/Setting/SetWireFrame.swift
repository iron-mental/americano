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
        
        
    }
    
    func presentMenuDetailScreen(from view: SetViewProtocol) {
        
    }
    
    
}
