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
        "authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJya2RjamYwMTIyQG5hdmVyLmNvbSIsIm5pY2tuYW1lIjoi64uJ64S067OA6rK97ZWo7JqUIiwiaWF0IjoxNjA2MjAyOTkyLCJleHAiOjEwNjA2MjAyOTkyLCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.E3gMKiM21Gu9J6tzAyYau7CEkwb5qAvXhGQapmSnM5o"
    ]
    //스터디 리스트 초기화시 호출되는 플로우
    static func getNewStudyList(_ category: String,
                                _ sort: String,
                                completionHandler: @escaping ([Study]) -> Void) {
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
    static func getNewStudyListForKey(_ keyValue: [Int],
                                      completionHandler: @escaping ([Study]) -> Void) {
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
    
    // 키값으로 스터디 디테일을 구하는 플로우
    static func getStudyDetail(_ keyValue: String,
                               completionHandler: @escaping (StudyDetail) -> Void) {
        let key = "http://3.35.154.27:3000/v1/study/\(keyValue)"
        
        AF.request(key, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("띠용",JSON(value))
                let json = "\(JSON(value))".data(using: .utf8)
                print(json)
                let result: StudyDetail = try! JSONDecoder().decode(StudyDetail.self, from: json!)
                print("get study detail:",result)
                
                completionHandler(result)
            case .failure(let err):
                print("실패", err)
            }
        }
    }
}
