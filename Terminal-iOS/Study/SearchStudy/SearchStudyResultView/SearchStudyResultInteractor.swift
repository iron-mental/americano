//
//  SearchStudyResultInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/04.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class SearchStudyResultInteractor: SearchStudyResultInteractorProtocol {
    var presenter: SearchStudyResultPresenterProtocol?
    var remoteDataManager: SearchStudyResultRemoteDataManagerProtocol?
    var localDataManager: SearchStudyResultLocalDataManagerProtocol?
    
    func getSearchStudyResult(keyWord: String) {
        remoteDataManager?.getSearchStudyResult(keyWord: keyWord)
    }
    
    func showSearchStudyResult(result: BaseResponse<[Study]>) {
        switch result.result {
        case true:
            presenter?.showSearchStudyResult(result: result.data!)
        case false:
            print("err")
        }
    }
}
