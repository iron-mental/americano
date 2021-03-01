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
        if UserDefaults.standard.object(forKey: "FirstInstall") == nil {
            UserDefaults.standard.set(false, forKey: "FirstInstall")
            UserDefaults.standard.synchronize()
            //첫 설치 혹은 앱 삭제후 재설치 이기 때문에 모두 삭제
            emptyAllToken()
        }
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            remoteDataManager?.getVersionCheck(version: version)
        }
    }
    
    func refreshTokenCheck() {
        if let userID = KeychainWrapper.standard.string(forKey: "userID") {
            remoteDataManager?.getRefreshTokenValid(userID: userID)
        } else {
            emptyAllToken()
            presenter?.refreshTokenIsEmpty()
        }
    }
    
    func emptyAllToken() {
        KeychainWrapper.standard.remove(forKey: "refreshToken")
        KeychainWrapper.standard.remove(forKey: "accessToken")
        KeychainWrapper.standard.remove(forKey: "pushToken")
        KeychainWrapper.standard.remove(forKey: "userID")
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
            //리프레시 토큰이 만료되었기에 로그아웃 시켜줄 것 이고 그전 토큰 모두 삭제 
            emptyAllToken()
            presenter?.refreshTokenResult(result: result.result)
        }
    }
}
