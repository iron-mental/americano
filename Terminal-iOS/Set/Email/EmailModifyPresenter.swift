//
//  EmailModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class EmailModifyPresenter: EmailModifyPresenterProtocol {
    var view: EmailModifyViewProtocol?
    var interactor: EmailModifyInteractorInputProtocol? 
    var wireFrame: EmailModifyWireFrameProtocol?
    
}

extension EmailModifyPresenter: EmailModifyInteractorOutputProtocol {
   
}