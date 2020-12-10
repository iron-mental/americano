//
//  SetRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/07.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class SetRemoteManager: SetRemoteDataManagerInputProtocol {
    var remoteRequestHandler: SetRemoteDataManagerOutputProtocol?
    
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
                    self.remoteRequestHandler?.onUserInfoRetrieved(userInfo: result)
                case .failure(let err):
                    print("실패")
                    print(err)
                }
            }
    }
}
