//
//  SearchStudyInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

final class SearchStudyInteractor: SearchStudyInteractorInputProtocol {
    weak var presenter: SearchStudyInteractorOutputProtocol?
    var remoteDataManager: SearchStudyRemoteDataManagerInputProtocol?
    
    //PRESENTER -> INTERACTOR
    func getHotKeyword() {
        remoteDataManager?.getHotKeyword()
    }
}

extension SearchStudyInteractor: SearchStudyRemoteDataManagerOutputProtocol {
    func getHotKeywordResult(response: BaseResponse<[HotKeyword]>) {
        switch response.result {
        case true:
            guard let keyword = response.data else { return }
            self.presenter?.getHotKeywordSuccess(keyword: keyword)
        case false:
            guard let message = response.message else { return }
            self.presenter?.getHotKeywordFailure(message: message)
        }
    }
    func sessionTaskError(message: String) {
        presenter?.sessionTaskError(message: message)
    }
}
