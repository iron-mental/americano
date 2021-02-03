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
    weak var interactor: SetRemoteDataManagerOutputProtocol?
    
    func getUserInfo() {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userInfo(id: userID))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data!)
                        self.interactor?.onUserInfoRetrieved(userInfo: result)
                    } catch {
                        print(error.localizedDescription)
                    }
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
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                        self.interactor?.emailAuthResponse(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
