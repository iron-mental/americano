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

class TerminalNetwork {
    static let headers: HTTPHeaders = [
        "authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJya2RjamYwMTIyQG5hdmVyLmNvbSIsIm5pY2tuYW1lIjoi64uJ64S067OA6rK97ZWo7JqUIiwiaWF0IjoxNjA2NDA1NDAxLCJleHAiOjEwNjA2NDA1NDAxLCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.FgCJIyemTA0YGkVA2qlRhPgjvm3CrDH0enqX_u9JPmc"
    ]
    
    static func checkToekn(accessToken: String, completion: @escaping (BaseResponse<UserInfo>) -> Void) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        let url = "http://3.35.154.27:3000/v1/user/\(userID)"
        
        let header: HTTPHeaders = [
            "authorization": accessToken
        ]
        
        AF.request(url, method: .get , headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(JSON(value))
                let json = JSON(value)
                let data = "\(json)".data(using: .utf8)
                let result = try! JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data!)
                completion(result)
            case .failure(let err):
                print(err)
            }
        }
    }
    
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
