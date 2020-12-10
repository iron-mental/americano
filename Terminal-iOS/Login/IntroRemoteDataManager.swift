//
//  IntroRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class IntroRemoteDataManager: IntroRemoteDataManagerProtocol {
    
    // MARK: 회원가입 이메일 유효성 검사
    
    func getEmailValidInfo(input: String, completionHandler: @escaping (BaseResponse<String>) -> Void) {
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.eamilCheck(email: input))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<String>.self, from: data!)
                    completionHandler(result)
                case .failure(let err):
                    print(err)
                }
            }
    }
    
    // MARK: 회원가입 유효성 검사
    
    func getSignUpValidInfo(signUpMaterial: [String], completionHandler: @escaping (BaseResponse<String>) -> Void) {
        let params: [String: String] = [
            "email" : signUpMaterial[0],
            "password" : signUpMaterial[1],
            "nickname" : signUpMaterial[2]
        ]
                
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.signUp(userData: params))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<String>.self, from: data!)
                    completionHandler(result)
                case .failure(let error):
                    print("에러:",error)
                }
            }
    }

    // MARK: 로그인 유효성 검사
    
    func getJoinValidInfo(joinMaterial: [String], completionHandler: @escaping (BaseResponse<JoinResult>) -> Void) {
        let params: [String: String] = [
            "email":"\(joinMaterial[0])",
            "password":"\(joinMaterial[1])",
            "push_token": KeychainWrapper.standard.string(forKey: "pushToken")!
        ]
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.login(userData: params))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("토큰 : ",JSON(value))
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<JoinResult>.self, from: data!)
                    completionHandler(result)
                case .failure(let error):
                    print("에러:",error)
                }
            }        
    }
}
