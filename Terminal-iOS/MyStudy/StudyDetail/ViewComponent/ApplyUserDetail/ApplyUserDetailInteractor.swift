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
        guard let id = userID else { return }
        remoteDataManager?.getUserInfo(userID: "\(id)")
        remoteDataManager?.getProjectList(userID: "\(id)")
    }
    func postRejectStatus() {
        remoteDataManager?.postApplyStatus(studyID: studyID!, applyID: applyID!, status: false)
    }
    
    func postAcceptStatus() {
        remoteDataManager?.postApplyStatus(studyID: studyID!, applyID: applyID!, status: true)
    }
}

extension ApplyUserDetailInteractor: ApplyUserDetailRemoteDataManagerOutputProtocol {
    
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>) {
        switch userInfo.result {
        case true:
            if let data = userInfo.data {
                presenter?.retriveUserInfo(result: userInfo.result, userInfo: data)
            }
            break
        case false:
            print("ApplyUserDetailInterator 에서 생긴 에러")
            break
        }
    }
    
    func onProjectRetrieved(project: BaseResponse<[Project]>) {
        switch project.result {
        case true:
            if let data = project.data {
                presenter?.retriveProjectList(result: project.result, projectList: data)
            }
            break
        case false:
            print("ApplyUserDetailInterator 에서 생긴 에러")
            break
        }
    }
    
    func onApplyStatusRetrieved(response: BaseResponse<String>) {
        switch response.result {
        case true:
            guard let message = response.message else { return }
            presenter?.retriveApplyStatus(result: response.result, message: message, studyID: studyID!)
            break
        case false:
            print("ApplyUserDetailInteractor 에서 생긴 에러")
            break
        }
    }
}
