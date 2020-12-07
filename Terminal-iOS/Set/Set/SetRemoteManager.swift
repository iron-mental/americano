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

class SetRemoteManager: SetRemoteDataManagerInputProtocol {
    var remoteRequestHandler: SetRemoteDataManagerOutputProtocol?
    
    func getUserInfo(id: Int) {
        let url = "http://3.35.154.27:3000/v1/user/\(id)"
        AF.request(url, headers: TerminalNetwork.headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(JSON(value))
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
