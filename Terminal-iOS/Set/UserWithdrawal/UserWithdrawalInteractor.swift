//
//  UserWithdrawalInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class UserWithdrawalInteractor: UserWithdrawalInteractorInputProtocol {
    var presenter: UserWithdrawalInteractorOutputProtocol?
    
    func userWithdrawal(email: String, password: String) {
        let params = [
            "email": email,
            "password": password
        ]
        
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userWithdrawal(id: userID, userData: params))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                        let isSuccess = result.result
                        let message = result.message ?? ""
                        self.presenter?.resultUserWithdrawal(result: isSuccess, message: message)
                        self.emptyAllToken()
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.presenter?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
                            let data = response.data
                            do {
                                let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                                let isSuccess = result.result
                                let message = result.message ?? ""
                                self.presenter?.resultUserWithdrawal(result: isSuccess, message: message)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
    }
}

extension UserWithdrawalInteractor {
    func emptyAllToken() {
        KeychainWrapper.standard.remove(forKey: "refreshToken")
        KeychainWrapper.standard.remove(forKey: "accessToken")
        KeychainWrapper.standard.remove(forKey: "pushToken")
    }
}
