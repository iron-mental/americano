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
        interactor?.retrieveAddress()
    }
    
    func completeModify(sido: String, sigungu: String) {
        interactor?.retrieveCoordinates(sido: sido, sigungu: sigungu)
    }
}

extension LocationModifyPresenter: LocationModifyInteractorOutputProtocol {
    func retrievedAddress(result: Bool, address: [Address]) {
        self.view?.showAddress(address: address)
    }
    
    func didCompleteModify(result: Bool, message: String) {
        self.view?.modifyResultHandle(result: result, message: message)
    }
}
