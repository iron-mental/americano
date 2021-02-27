//
//  IntroRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class IntroRemoteDataManager: IntroRemoteDataManagerProtocol {
    
    // MARK: 회원가입 이메일 유효성 검사
    
    func getEmailValidInfo(input: String, completionHandler: @escaping (BaseResponse<String>) -> Void) {
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.eamilCheck(email: input))
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                        completionHandler(result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    print(err)
                }
            }
    }
    
    // MARK: 회원가입 유효성 검사
    
    func getSignUpValidInfo(signUpMaterial: [String], completionHandler: @escaping (BaseResponse<String>) -> Void) {
        
        let params: [String: String] = [
            "email": signUpMaterial[0],
            "password": signUpMaterial[1],
            "nickname": signUpMaterial[2]
        ]
                
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.signUp(userData: params))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                        completionHandler(result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                            completionHandler(result)
                        } catch {
                            
                        }
                    }
                }
            }
    }

    // MARK: 로그인 유효성 검사
    
    func getJoinValidInfo(joinMaterial: [String], completionHandler: @escaping (BaseResponse<JoinResult>) -> Void) {
        var params: [String: String] = [:]
        if let pushToken = KeychainWrapper.standard.string(forKey: "pushToken") {
            params = [
                "email": "\(joinMaterial[0])",
                "password": "\(joinMaterial[1])",
                "push_token": pushToken,
                "device": "ios"
            ]
        } else {
//            시뮬전용
            params  = [
                "email": "\(joinMaterial[0])",
                "password": "\(joinMaterial[1])",
                "push_token": "334324ㅁㄴㅇㄹ",
                "device": "ios"
            ]
        }
        
        print(KeychainWrapper.standard.string(forKey: "accessToken") as Any)
        print(KeychainWrapper.standard.string(forKey: "refreshToken") as Any)
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.login(userData: params))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<JoinResult>.self, from: data)
                        completionHandler(result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<JoinResult>.self, from: data)
                            completionHandler(result)
                        } catch {
                            
                        }
                    }
                }
            }        
    }
}
