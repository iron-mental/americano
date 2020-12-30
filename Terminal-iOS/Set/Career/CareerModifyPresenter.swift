//
//  CareerModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CareerModifyPresenter: CareerModifyPresenterProtocol {
    var view: CareerModifyViewProtocol?
    var interactor: CareerModifyInteractorInputProtocol?
    var wireFrame: CareerModifyWireFrameProtocol?
    
    func completeModify(title: String, contents: String) {
        interactor?.completeModify(title: title, contents: contents)
    }
}

extension CareerModifyPresenter: CareerModifyInteractorOutputProtocol {
    
}
