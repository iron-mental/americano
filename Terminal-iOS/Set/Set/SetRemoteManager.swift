//
//  SetRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/07.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftKeychainWrapper

class SetRemoteManager: SetRemoteDataManagerInputProtocol {
    var interactor: SetRemoteDataManagerOutputProtocol?
    
    func getUserInfo() {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userInfo(id: userID))
            .validate(statusCode: 200..<299)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data!)
                    self.interactor?.onUserInfoRetrieved(userInfo: result)
                case .failure:
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
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                    self.interactor?.emailAuthResponse(result: result)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
