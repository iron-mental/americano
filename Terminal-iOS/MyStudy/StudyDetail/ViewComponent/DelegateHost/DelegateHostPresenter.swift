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
        <#code#>
    }
}

extension DelegateHostPresenter: DelegateHostInteractorOutputProtocol {
    func delegateHostResult(result: Bool, message: String) {
        <#code#>
    }
}
