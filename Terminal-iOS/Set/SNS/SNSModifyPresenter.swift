//
//  SNSModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class SNSModifyPresenter: SNSModifyPresenterProtocol {
    var view: SNSModifyViewProtocol?
    var interactor: SNSModifyInteractorInputProtocol?
    var wireFrame: SNSModifyWireFrameProtocol?
    
}

extension SNSModifyPresenter: SNSModifyInteractorOutputProtocol {
    
}
