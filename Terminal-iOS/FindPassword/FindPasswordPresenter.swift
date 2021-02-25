//
//  FindPasswordPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

final class FindPasswordPresenter: FindPasswordPresenterProtocol {
    var view: FindPasswordViewProtocol?
    var interactor: FindPasswordInteractorInputProtocol?
    var wireFrame: FindPasswordWireFrameProtocol?
    
    
}

extension FindPasswordPresenter: FindPasswordInteractorOutputProtocol {
    
}
