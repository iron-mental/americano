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
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
    
        request.addValue(API.ACCESS_TOKEN, forHTTPHeaderField: "authorization")

        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        refreshToken { success in
            success ? completion(.retry) : completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        guard let refreshToken = KeychainWrapper.standard.string(forKey: "refreshToken"),
            let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") else { return }
        let parameters: [String: String] = [
            "refresh_token": refreshToken
        ]
        
        let header: HTTPHeaders = [
            "authorization": accessToken
        ]
        
        let url = API.BASE_URL + "/v1/user/reissuance"
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Authorization>.self, from: data!)
                        if let refresh = result.data?.refreshToken {
                            let result = KeychainWrapper.standard.set(refresh, forKey: "refreshToken")
                            print("엑세스 토큰 갱신 여부 :", result)
                        }
                        
                        if let access = result.data?.accessToken {
                            let result = KeychainWrapper.standard.set(access, forKey: "accessToken")
                            print("엑세스 토큰 갱신 여부 :", result)
                            completion(true)
                        } else {
                            completion(false)
                        }
                    } catch {
                        print("error")
                    }
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
}
