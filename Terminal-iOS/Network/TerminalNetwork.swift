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
    
    //스터디 리스트 초기화시 호출되는 플로우
    static func getNewStudyList(_ category: String, _ sort: String, completionHandler: @escaping ([Study])->(), completion: @escaping ([Int]) -> ()) {
        let url = "http://3.35.154.27:3000/v1/study?category=\(category)&sort=\(sort)"
        var studyArr: [Study] = []
        var keyArr: [Int] = []
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let data = JSON(value)["data"].array {
                    do {
                        for index in data {
                            if index["title"].string != nil {
                                let data = "\(index)".data(using: .utf8)
                                let result = try! JSONDecoder().decode(Study.self, from: data!)
                                studyArr.append(result)
                            }
                                                        
                            // contents 없는 키값 구할때
                            if index["title"].string == nil {
                                if let data = index.int {
                                    keyArr.append(data)
                                }
                            }
                        }
                        completionHandler(studyArr)
                        completion(keyArr)
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

        AF.request(query).responseJSON { response in
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
    static func getStudyDetail(_ keyValue: String, completionHandler: @escaping (StudyDetail) -> ()) {
        let key = "http://3.35.154.27:3000/v1/study/\(keyValue)"
        
        AF.request(key).responseJSON { response in
            switch response.result {
                case .success(let value):
                    let json = "\(JSON(value))".data(using: .utf8)
                    let result: StudyDetail = try! JSONDecoder().decode(StudyDetail.self, from: json!)
                    completionHandler(result)
                case .failure(let err):
                    print("실패", err)
            }
        }
    }
}
