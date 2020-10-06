//
//  SetViewPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class SetViewPresenter: SetViewPresenterProtocol {
    
    var view: SetViewProtocol?
    
    var interactor: SetViewInteractortInputProtocol?
    
    var wireFrame: SetViewWireFrameProtocol?
    
    func viewDidLoad() {
        
    }
    
    func showProfileDetail() {
        
    }
    
}

extension SetViewPresenter: SetViewInteractorOutputProtocol {
    
}
