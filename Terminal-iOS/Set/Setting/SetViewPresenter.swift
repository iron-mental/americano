//
//  SetViewPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class SetPresenter: SetPresenterProtocol {
    var view: SetViewProtocol?
    
    var interactor: SetInteractortInputProtocol?
    
    var wireFrame: SetWireFrameProtocol?
    
    func viewDidLoad() {
        
    }
    
    func showProfileDetail() {
        
    }
    
}

extension SetPresenter: SetInteractorOutputProtocol {
    
}
