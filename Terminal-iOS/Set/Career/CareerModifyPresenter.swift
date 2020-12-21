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
    
}

extension CareerModifyPresenter: CareerModifyInteractorOutputProtocol {
    
}
