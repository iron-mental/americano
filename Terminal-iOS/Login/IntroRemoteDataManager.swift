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

class IntroRemoteDataManager: IntroRemoteDataManagerProtocol {
    func getEmailValidInfo(input: String,  completionHandler: @escaping (_ : Bool) -> ()) {
        var result = false
        let urlComponents = URLComponents(string: "http://3.35.154.27:3000/v1/user/check-email")
        guard var url = urlComponents?.url else { return }
        url.appendPathComponent("\(input)")
            AF.request(url, encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response)
                    result = JSON(response.data)["result"].bool!
                    completionHandler(result)
                }.resume()
    }
    
    func getSignUpValidInfo(signUpMaterial: [String]) -> Bool {
        var params: Parameters = [:]
        params = [
            "email" : signUpMaterial[0],
            "password" : signUpMaterial[1],
            "nickname" : signUpMaterial[2]
        ]
        
        var result =  false
        let url = URL(string: "http://3.35.154.27:3000/v1/user")!
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            result = JSON(response.data)["result"].bool!
        }.resume()
        return result
    }
    
    func getJoinValidInfo(joinMaterial: [String], completionHandler: @escaping (_ result: Bool, _ message: Any) -> ()) {
        var params: Parameters = [
            "email":"\(joinMaterial[0])",
            "password":"\(joinMaterial[1])"
        ]
        var url = URL(string: "http://3.35.154.27:3000/v1/user/login")!
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            var result = JSON(response.data)["result"].bool!
            switch result {
            case true:
                print(JSON(response.data)["data"]["id"])
                var data = JSON(response.data)["data"]["id"].int!
                completionHandler(result, data)
                break
            case false:
                print(JSON(response.data)["result"])
                var data = JSON(response.data)["message"].string!
                completionHandler(result, data)
                break
            }
//            completionHandler(result, data)
        }.resume()
        
    }
}
