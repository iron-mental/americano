//
//  LaunchInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/23.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class LaunchInteractor: LaunchInteractorInputProtocol {
    weak var presenter: LaunchInteractorOutputProtocol?
    var remoteDataManager: LaunchRemoteDataManagerInputProtocol?
    
    func getVersionCheck() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            remoteDataManager?.getVersionCheck(version: version)
        }
    }
    
    func refreshTokenCheck() {
        if let userID = KeychainWrapper.standard.string(forKey: "userID") {
            remoteDataManager?.getRefreshTokenValid(userID: userID)
        } else {
            presenter?.refreshTokenIsEmpty()
        }
    }
}

extension LaunchInteractor: LaunchRemoteDataManagerOutputProtocol {
    func getVersionResult(result: BaseResponse<VersionResult>) {
        switch result.result {
        case true:
            if result.data != nil {
                switch VersionResultType(rawValue: result.data!.force) {
                case .notRequired:
                    refreshTokenCheck()
                case .Recommended:
                    presenter?.versionNeedUpdate(force: .Recommended)
                case .Required:
                    presenter?.versionNeedUpdate(force: .Required)
                case .none: break
                }
            }
        case false: break
        // 프레젠터 에러로 넘겨줌
        }
    }
    
    func getRefreshTokenResult(result: BaseResponse<UserInfo>) {
        switch result.result {
        case true:
            presenter?.refreshTokenResult(result: result.result)
        case false:
            presenter?.refreshTokenResult(result: result.result)
        }
    }
}
