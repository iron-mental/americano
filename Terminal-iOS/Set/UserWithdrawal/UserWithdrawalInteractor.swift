//
//  UserWithdrawalInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON
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
            .validate(statusCode: 200...400)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                        let isSuccess = result.result
                        let message = result.message ?? ""
                        self.presenter?.resultUserWithdrawal(result: isSuccess, message: message)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
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
