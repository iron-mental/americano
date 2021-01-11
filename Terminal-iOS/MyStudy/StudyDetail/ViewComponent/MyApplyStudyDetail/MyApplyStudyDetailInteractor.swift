//
//  MyApplyStudyDetailInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class MyApplyStudyDetailInteractor: MyApplyStudyDetailInteractorInputProtocol {
    var presenter: MyApplyStudyDetailInteractorOutputProtocol?
    var remoteDataManager: MyApplyStudyDetailRemoteDataManagerInputProtocol?
    var applyID: Int?
    func getMyApplyStudyDetail(studyID: Int) {
        if let userInfo = CoreDataManager.shared.getUserinfo() {
            remoteDataManager?.getMyApplyStudyDetail(studyID: studyID, userID: userInfo.id)
        }
    }
}

extension MyApplyStudyDetailInteractor: MyApplyStudyDetailRemoteDataManagerOutputProtocol {
    func retriveMyApplyStudyDetail(result: Bool, data: ApplyUserResult) {
        switch result {
        case true:
            applyID = data.id
            let message = data.message
            presenter?.retriveMyApplyStudyDetail(result: result, message: message)
        case false:
            print("MyApplyStudyDetailInteractor 에서 에러남")
        }
    }
}
