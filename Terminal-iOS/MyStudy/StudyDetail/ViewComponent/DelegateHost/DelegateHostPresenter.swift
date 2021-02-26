//
//  DelegateHostPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class DelegateHostPresenter: DelegateHostPresenterProtocol {
    weak var view: DelegateHostViewProtocol?
    var interactor: DelegateHostInteractorInputProtocol?
    var wireFrame: DelegateHostWireFrameProtocol?
    
    func delegateHostButtonDidTap(newLeader: Int) {
        interactor?.putDelegateHostAPI(newLeader: newLeader)
    }
}

extension DelegateHostPresenter: DelegateHostInteractorOutputProtocol {
    func delegateHostResult(result: Bool, message: String) {
            switch result {
            case true:
                TerminalAlertMessage.dismiss()
                self.view?.showDelegateHostResult(message: message)
            case false:
                TerminalAlertMessage.dismiss()
                self.view?.showError(message: message)
            }
    }
}
