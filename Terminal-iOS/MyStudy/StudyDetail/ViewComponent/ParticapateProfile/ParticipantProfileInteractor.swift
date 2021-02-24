//
//  ParticipantProfileInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/24.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ParticipantProfileInteractor: ParticipantProfileInteractorInputProtocol {
    weak var presenter: ParticipantProfileInteractorOutputProtocol?
    var remoteDataManager: ParticipantProfileRemoteDataManagerInputProtocol?
    var userID: Int?
    
    func getUserInfo() {
        guard let id = userID else { return }
        remoteDataManager?.getUserInfo(userID: String(id))
        remoteDataManager?.getProjectList(userID: String(id))
    }
}

extension ParticipantProfileInteractor: ParticipantProfileRemoteDataManagerOutputProtocol {
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>) {
        switch userInfo.result {
        case true:
            if let data = userInfo.data {
                presenter?.retriveUserInfo(result: userInfo.result, userInfo: data)
            }
        case false:
            if let message = userInfo.message {
                presenter?.showError(message: message)
            }
        }
    }
    
    func onProjectRetrieved(project: BaseResponse<[Project]>) {
        switch project.result {
        case true:
            if let data = project.data {
                presenter?.retriveProjectList(result: project.result, projectList: data)
            }
        case false:
            if let message = project.message {
                presenter?.showError(message: message)
            }
        }
    }
    
}
