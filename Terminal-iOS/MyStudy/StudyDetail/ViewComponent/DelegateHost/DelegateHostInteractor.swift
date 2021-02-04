//
//  DelegateHostInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class DelegateHostInteractor: DelegateHostInteractorInputProtocol {
    weak var presenter: DelegateHostInteractorOutputProtocol?
    var remoteDataManager: DelegateHostRemoteDataManagerInputProtocol?
    var studyID: Int?
    
    func putDelegateHostAPI(newLeader: Int) {
        remoteDataManager?.putDelegateHostAPI(studyID: studyID!, newLeader: newLeader)
    }
    
}

extension DelegateHostInteractor: DelegateHostRemoteDataManagerOutputProtocol {
    func delegateHostResult(response: BaseResponse<String>) {
        switch response.result {
        case true:
            presenter?.delegateHostResult(result: response.result, message: response.message!)
            break
        case false:
            if let message = response.message {
                presenter?.delegateHostResult(result: response.result, message: message)
            } else {
                presenter?.delegateHostResult(result: response.result, message: "false에 메세지 없ㅇ므")
            }
            break
        }
    }
}
