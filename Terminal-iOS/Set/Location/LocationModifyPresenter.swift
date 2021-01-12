//
//  LocationModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class LocationModifyPresenter: LocationModifyPresenterProtocol {
    var view: LocationModifyViewProtocol?
    var interactor: LocationModifyInteractorInputProtocol?
    var wireFrame: LocationModifyWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.address()
    }
}

extension LocationModifyPresenter: LocationModifyInteractorOutputProtocol {
    func retrievedAddress(result: Bool, address: [Address]) {
        self.view?.showAddress(address: address)
    }
}
