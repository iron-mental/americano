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
    func getEmailValidInfo(input: String) -> Bool {
        print(input)
        let params : [String : Any] = [
            "email" : input
        ]
        var urlComponents = URLComponents(string: "http://3.35.154.27:3000/v1/user/check-email")
        guard var url = urlComponents?.url else { return false }
        
        url.appendPathComponent("\(input)")
        AF.request(url, encoding: JSONEncoding.default)
            .responseJSON { response in
//                let result: SocketMessage = try! JSONDecoder().decode(SocketMessage.self, from: "\(JSON(response.data))".data(using: .utf8))
                
                print(JSON(response.data)["message"])
                print(JSON(response.data)["result"])
            }.resume()
        return true
    }
    
    func getSignUpValidInfo() {
        print("signupvalid")
    }
}
