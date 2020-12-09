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
        
        let tese2: Parameters = [
            "title": "첫 번째 공지사항",
            "contents": "마스크 지참하세요",
            "pinned": "true"
        ]
        
//        let url = "http://3.35.154.27:3000/v1/study/222/notice"
////        (url, method: .post, parameters: tese2, encoding: URLEncoding.default, headers: TerminalNetwork.temp22)
//        AF.request(url, method: .post, parameters: tese2, encoding: JSONEncoding.default, headers: TerminalNetwork.temp22)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    print(JSON(value))
//                case .failure(let err):
//                    print(err)
//            }
//        }
                
//        print(KeychainWrapper.standard.string(forKey: "accessToken"))
//        print(KeychainWrapper.standard.string(forKey: "refreshToken"))
//        let parameters: Parameters = [
//            "category": "ios",
//            "sort": "new",
//        ]
        
//        TerminalNetworkManager
//            .shared
//            .session
//            .request(TerminalRouter.studyList(category: "ios", sort: "new"))
//            .validate(statusCode: 200...299)
//            .responseJSON { response in
//                 debugPrint(response)
//            }
//
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.createNotice(studyID: "222", notice: ["title" : "첫 번째 공지사항",
                                                                         "contents" : "마스크 지참하세요",
                                                                         "pinned" : "true"]))
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
