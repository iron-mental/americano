//
//  ProfileModifyRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProfileModifyRemoteManager: ProfileModifyRemoteDataManagerInputProtocol {
    var remoteRequestHandler: ProfileModifyRemoteDataManagerOutputProtocol?
    
    func validProfileModify(userInfo: UserInfoPut) {
        let url = "http://3.35.154.27:3000/v1/user/23"
        
        AF.request(url, method: .put, encoding: JSONEncoding.default, headers: TerminalNetwork.headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(JSON(value))
            case .failure(let error):
                print(error)
            }
        }
    }
}
