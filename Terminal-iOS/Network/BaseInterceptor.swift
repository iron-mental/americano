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

final class BaseInterceptor: RequestInterceptor {
    let retryLimit = 10
    let retryDelay: TimeInterval = 0.5
    var accessToken: String = ""
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var request = urlRequest
        if let token = KeychainWrapper.standard.string(forKey: "accessToken") {
            self.accessToken = token
        }
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "authorization")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        print("statusCode:", statusCode)
        switch statusCode {
        case 400, 402...503:
            completion(.doNotRetry)
        case 401:
            if request.retryCount < retryLimit {
                refreshToken { result in
                    switch result {
                    case true:
                        return completion(.retryWithDelay(self.retryDelay))
                    case false:
                        /// refreshToken 만료시 로그아웃
                        DispatchQueue.main.async {
                            let view = HomeView()
                            let home = UINavigationController(rootViewController: view)
                            /// 로그아웃과 동시에  토큰 삭제
                            KeychainWrapper.standard.remove(forKey: "refreshToken")
                            // RootViewController replace
                            guard let window = UIApplication.shared.windows.first else { return }
                            window.replaceRootViewController(home, animated: true, completion: nil)
                        }
                    }
                }
            }
        default: break
        }
        
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        //리프레시토큰 없을 때 로그아웃 뷰로 가야됨
        if let refreshToken = KeychainWrapper.standard.string(forKey: "refreshToken") {
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
                                    print("리프레쉬 토큰 갱신 여부 :", result)
                                }
                                if let access = result.data?.accessToken {
                                    let result = KeychainWrapper.standard.set(access, forKey: "accessToken")
                                    print("엑세스 토큰 갱신 여부 :", result)
                                    completion(result)
                                }
                            } else {
                                completion(false)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        //리프레시 마저 만료
                        completion(false)
                    }
                }
        } else {
            completion(false)
        }
    }
}
