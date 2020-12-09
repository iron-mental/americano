//
//  TestViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/03.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import SwiftyJSON

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
//        print(KeychainWrapper.standard.string(forKey: "accessToken"))
//        print(KeychainWrapper.standard.string(forKey: "refreshToken"))
//        let parameters: Parameters = [
//            "category": "ios",
//            "sort": "new",
//        ]
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyListGet(category: "ios", sort: "new"))
            .validate(statusCode: 200...299)
            .responseJSON { response in
                 debugPrint(response)
            }
        
//        let url = "http://3.35.154.27:3000/v1/study"
//
        
//
//        AF.request(url,
//                   method: .get,
//                   parameters: parameters,
//                   encoding: URLEncoding.queryString,
//                   headers: TerminalNetwork.headers)
//            .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                print(JSON(value))
//            case .failure(let err):
//                print(err)
//            }
//        }
    }
}
