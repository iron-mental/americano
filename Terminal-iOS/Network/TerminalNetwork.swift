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

class TerminalNetwork {
    static private let headers: HTTPHeaders = [
        "authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2MDUyNTg3MTcsImV4cCI6MTYwNjU1NDcxNywiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.ERdupceGRDZAJbnA6hgstoUUYwMoaxm_kqxXneJM6Xo"
    ]
    //스터디 리스트 초기화시 호출되는 플로우
    static func getNewStudyList(_ category: String, _ sort: String, completionHandler: @escaping ([Study])->()) {
        let url = "http://3.35.154.27:3000/v1/study?category=\(category)&sort=\(sort)"
        var studyArr: [Study] = []
        
        AF.request(url, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let data = JSON(value)["data"].array {
                    do {
                        for index in data {
                            print(index)
                            let data = "\(index)".data(using: .utf8)
                            let result = try! JSONDecoder().decode(Study.self, from: data!)
                            studyArr.append(result)
                        }
                        completionHandler(studyArr)
                    } catch {
                        print("error")
                    }
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    // 스터디 키값으로 가져오는 플로우
    static func getNewStudyListForKey(_ keyValue: [Int], completionHandler: @escaping ([Study]) -> ()) {
        let key = "\(keyValue)".trimmingCharacters(in: ["["]).trimmingCharacters(in: ["]"]).removeWhitespace()
        let query = "http://3.35.154.27:3000/v1/study/paging/list?values=\(key)"
        var studyArr: [Study] = []
        AF.request(query, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let data = JSON(value)["data"].array {
                    for index in data {
                        let data = "\(index)".data(using: .utf8)
                        let result = try! JSONDecoder().decode(Study.self, from: data!)
                        studyArr.append(result)
                    }
                    completionHandler(studyArr)
                }
            case .failure(let err):
                print("실패", err)
            }
        }
    }
    
    
}
