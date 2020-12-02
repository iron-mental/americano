//
//  TerminalNetwork.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/12.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON
import SwiftKeychainWrapper

class TerminalNetwork{    
    static var headers: HTTPHeaders = [
        "authorization": KeychainWrapper.standard.string(forKey: "accessToken")!
    ]
    
    // 자동로그인시에 유저조회를 통해서 엑세스 토큰 확인
    static func checkToekn(accessToken: String, completion: @escaping (BaseResponse<UserInfo>) -> Void) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        let url = "http://3.35.154.27:3000/v1/user/\(userID)"
        
        let header: HTTPHeaders = [
            "authorization": accessToken
        ]
        
        AF.request(url,
                   method: .get,
                   headers: header)
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = "\(json)".data(using: .utf8)
                let result = try! JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data!)
                completion(result)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    // 토큰 갱신을 위한 API
    static func authRequest(refreshToken: String, accessToken: String, completion: @escaping (BaseResponse<Authorization>) -> Void) {
        let url = "http://3.35.154.27:3000/v1/user/reissuance"
        let parameters: [String: String] = [
            "refresh_token": refreshToken
        ]
        
        let header: HTTPHeaders = [
            "authorization": accessToken
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(JSON(value))
                let json = JSON(value)
                let data = "\(json)".data(using: .utf8)
                let result = try! JSONDecoder().decode(BaseResponse<Authorization>.self, from: data!)
                completion(result)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getJoinValid(joinMaterial: [String]) {
        var params: Parameters = [
            "email":"\(joinMaterial[0])",
            "password":"\(joinMaterial[1])"
        ]
        
        let url = "http://3.35.154.27:3000/v1/user/login"
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = "\(json)".data(using: .utf8)
                let result = try! JSONDecoder().decode(BaseResponse<Authorization>.self, from: data!)
                
            case .failure(let err):
                print(err)
            }
        }
    }
}
