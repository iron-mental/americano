//
//  DelegateHostInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class DelegateHostInteractor: DelegateHostInteractorInputProtocol {
    var presenter: DelegateHostInteractorOutputProtocol?
    var remoteDataManager: DelegateHostRemoteDataManagerInputProtocol?
    var studyID: Int?
    
    func putDelegateHostAPI(newLeader: Int) {
        <#code#>
    }
    
}

extension DelegateHostInteractor: DelegateHostRemoteDataManagerOutputProtocol {
    func delegateHostResult(response: BaseResponse<String>) {
        <#code#>
    }
}
