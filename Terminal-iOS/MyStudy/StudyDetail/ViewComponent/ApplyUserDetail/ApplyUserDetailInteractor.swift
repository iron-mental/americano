//
//  ApplyUserDetailInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/15.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ApplyUserDetailInteractor: ApplyUserDetailInteractorInputProtocol {
    weak var presenter: ApplyUserDetailInteractorOutputProtocol?
    var remoteDataManager: ApplyUserDetailRemoteDataManagerInputProtocol?
    
    var studyID: Int?
    var applyID: Int?
    var userID: Int?
    
    func getUserInfo() {
        remoteDataManager?.getApplyUserInfo(studyID: studyID!, applyID: applyID!)
    }
    
    func postRejectStatus() {
        print("studyID: ", studyID!)
        print("applyID: ", applyID!)
        remoteDataManager?.postApplyStatus(studyID: studyID!, applyID: applyID!, status: false)
    }
    
    func postAcceptStatus() {
        remoteDataManager?.postApplyStatus(studyID: studyID!, applyID: applyID!, status: true)
    }
}

extension ApplyUserDetailInteractor: ApplyUserDetailRemoteDataManagerOutputProtocol {
    
    func onUserInfoRetrieved(userInfo: BaseResponse<ApplyUserInfo>) {
        switch userInfo.result {
        case true:
            if let data = userInfo.data {
                presenter?.retriveUserInfo(result: userInfo.result, userInfo: data)
            }
        case false:
            print("ApplyUserDetailInterator 에서 생긴 에러")
        }
    }
    
    func onApplyStatusRetrieved(response: BaseResponse<String>) {
        switch response.result {
        case true:
            guard let message = response.message else { return }
            presenter?.retriveApplyStatus(result: response.result, message: message, studyID: studyID!)
        case false:
            guard let message = response.message else { return }
            presenter?.retriveApplyStatus(result: response.result, message: message, studyID: studyID!)
        }
    }
    
    func sessionTaskError(message: String) {
        presenter?.sessionTaskError(message: message)
    }
}
