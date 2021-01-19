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
            .validate(statusCode: 200..<500)
            .responseJSON { reponse in
                switch reponse.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}
