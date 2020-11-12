//
//  TerminalNetwork.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/12.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TerminalNetwork {
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
                                let temp = try! Study(title: index["title"].string!, subTitle: index["introduce"].string!, location: "강남구", date: index["created_at"].string!, managerImage: UIImage(named: "leehi")!, mainImage: UIImage(named: "mainImage")!)
                                studyArr.append(temp)
                            }
                            
                            // contents 들어있는 키값을 구할때
                            if index["id"].int != nil {
                                if let data = index["id"].int {
                                    keyArr.append(data)
                                }
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
    
    static func getNewStudyListForKey(_ keyValue: [Int], completionHandler: @escaping ([Study]) -> ()) {
        let key = "\(keyValue)".trimmingCharacters(in: ["["]).trimmingCharacters(in: ["]"]).removeWhitespace()
        let query = "http://3.35.154.27:3000/v1/study/paging/list?values=\(key)"
        var studyArr: [Study] = []
        
        AF.request(query).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let data = JSON(value)["data"].array {
                    for index in data {
                        let temp = Study(title: index["title"].string!, subTitle: index["introduce"].string!, location: "강남구", date: index["created_at"].string!, managerImage: UIImage(named: "leehi")!, mainImage: UIImage(named: "mainImage")!)
                        studyArr.append(temp)
                    }
                    completionHandler(studyArr)
                }
            case .failure(let err):
                print("실패")
            }
        }
    }
}
