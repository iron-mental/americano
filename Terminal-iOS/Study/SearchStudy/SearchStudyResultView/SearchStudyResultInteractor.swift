//
//  SearchStudyResultInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/04.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class SearchStudyResultInteractor: SearchStudyResultInteractorInputProtocol {
    var presenter: SearchStudyResultInteractorOutputProtocol?
    var remoteDataManager: SearchStudyResultRemoteDataManagerInputProtocol?
    
    var studyList: [Study] = []
    var isPagingStudyList: [Int] = []
    
    func getSearchStudyResult(keyWord: String) {
        remoteDataManager?.getSearchStudyResult(keyWord: keyWord)
    }
    
    func showSearchStudyResult(result: BaseResponse<[Study]>) {
        switch result.result {
        case true:
            if let itemList = result.data {
                self.studyList = itemList.filter { !$0.isPaging! }
                self.isPagingStudyList = (itemList.filter { $0.isPaging! }).map { $0.id }
            }
            presenter?.showSearchStudyResult(result: studyList)
        case false:
            print("err")
        }
    }
}


