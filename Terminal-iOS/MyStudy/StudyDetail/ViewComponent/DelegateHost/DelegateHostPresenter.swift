//
//  DelegateHostPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class DelegateHostPresenter: DelegateHostPresenterProtocol {
    var view: DelegateHostViewProtocol?
    var interactor: DelegateHostInteractorInputProtocol?
    var wireFrame: DelegateHostWireFrameProtocol?
    
    func delegateHostButtonDidTap(newLeader: Int) {
        LoadingRainbowCat.show()
        interactor?.putDelegateHostAPI(newLeader: newLeader)
    }
}

extension DelegateHostPresenter: DelegateHostInteractorOutputProtocol {
    func delegateHostResult(result: Bool, message: String) {
        LoadingRainbowCat.hide {
            switch result {
            case true:
                view?.showDelegateHostResult(message: message)
                break
            case false:
                view?.showError()
                break
            }
        }
    }
}
