//
//  ProfileDetailRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/26.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProfileDetailRemoteManager: ProfileDetailRemoteDataManagerInputProtocol {
    var remoteRequestHandler: ProfileDetailRemoteDataManagerOutputProtocol?
    
    func getUserInfo(id: Int) {
        let url = "http://3.35.154.27:3000/v1/user/1"
        AF.request(url, headers: TerminalNetwork.headers).responseJSON { response in
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
