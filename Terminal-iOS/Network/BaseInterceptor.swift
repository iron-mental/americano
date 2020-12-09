//
//  BaseInterceptor.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/03.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper
import SwiftyJSON

class BaseInterceptor: RequestInterceptor {
    var isRefreshing: Bool = false
    var validToken: String?
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest

        guard let access = KeychainWrapper.standard.string(forKey: "accessToken") else { return }
        request.setValue("Bearer \(access)", forHTTPHeaderField: "authorization")

        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        switch statusCode {
        case 200...299:
            completion(.doNotRetry)
        default:
            refreshToken { success in
                print("성공여부 :",success)
                return completion(.retry)
            }
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        guard let refreshToken = KeychainWrapper.standard.string(forKey: "refreshToken") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.reissuanceToken(refreshToken: refreshToken))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Authorization>.self, from: data!)
                        if result.result {
                            if let refresh = result.data?.refreshToken {
                                let result = KeychainWrapper.standard.set(refresh, forKey: "refreshToken")
                                print("엑세스 토큰 갱신 여부 :", result)
                            }
                            
                            if let access = result.data?.accessToken {
                                let result = KeychainWrapper.standard.set(access, forKey: "accessToken")
                                print("엑세스 토큰 갱신 여부 :", result)
                                
                                completion(result)
                            }
                        }
                    } catch {
                        print("error")
                    }
                    
                case .failure(let error):
                    print("에러입니다.",error)
                }
            }
    }
}
