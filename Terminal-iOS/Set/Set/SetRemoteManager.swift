//
//  SetRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/07.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

final class SetRemoteManager: SetRemoteDataManagerInputProtocol {
    weak var interactor: SetRemoteDataManagerOutputProtocol?
    
    func getUserInfo() {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userInfo(id: userID))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data)
                        self.interactor?.onUserInfoRetrieved(userInfo: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.interactor?
                                .sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default: break
                        }
                    }
                    self.interactor?.error()
                }
            }
    }
    
    func emailAuthRequest() {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.emailVerify(id: userID))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                        self.interactor?.emailAuthResponse(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.interactor?
                                .sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default: break
                        }
                    }
                }
            }
    }
    
    func postLogout(userID: String) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.logout(userID: userID))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                        if result.message != nil {
                            self.interactor?.postLogoutResult(result: result)
                        }
                    } catch {
                        
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.interactor?
                                .sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
                            if let data = response.data {
                                do {
                                    let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                                    if result.message != nil {
                                        self.interactor?.postLogoutResult(result: result)
                                    }
                                } catch {
                                    
                                }
                            }
                        }
                    }
                }
            }
    }
}
