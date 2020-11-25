//
//  StudyListRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StudyListRemoteDataManager: StudyListRemoteDataManagerInputProtocol {
    var remoteRequestHandler: StudyListRemoteDataManagerOutputProtocol?
    
    var studyArr: [Study] = []
    var studyKeyArr: [Study] = []
    var keyValue: [Int] = []
    var newKeyValue: [Int] = []
    
    //MARK: 리스트 검색시 초기 배열값
    
    func retrieveStudyList(category: String, sort: String) {
        let url = "http://3.35.154.27:3000/v1/study?category=\(category)&sort=\(sort)"
        var resultArr: [Study] = []
        AF.request(url, headers: TerminalNetwork.headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                if let data = JSON(value)["data"].array {
                        for index in data {
                            let data = "\(index)".data(using: .utf8)
                            let result = try! JSONDecoder().decode(Study.self, from: data!)
                            resultArr.append(result)
                        }
                        
                        /// 키값만 내려오는 배열
                        for data in resultArr {
                            if data.title == nil {
                                self.studyKeyArr.append(data)
                            }
                        }
                        
                        /// 모든 데이터가 내려오는 배열
                        for data in resultArr {
                            if data.title != nil {
                                print(data)
                                self.studyArr.append(data)
                            }
                        }

                    self.remoteRequestHandler?.onStudiesRetrieved(self.studyArr)
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    //MARK: key 값을 통한 페이징
    
    func paginationRetrieveStudyList() {
        
        /// 스터디 키값이 10개가 넘을경우
        if studyKeyArr.count >= 10 {
            for _ in 0..<10 {
                newKeyValue.append(studyKeyArr[0].id)
                studyKeyArr.remove(at: 0)
            }
        } else {
            for _ in 0..<studyKeyArr.count {
                newKeyValue.append(studyKeyArr[0].id)
                studyKeyArr.remove(at: 0)
            }
        }
        
        /// 키값이 0개 이상 즉, 존재할때 API Call
        if newKeyValue.count > 0 {
            let key = "\(newKeyValue)".trimmingCharacters(in: ["["]).trimmingCharacters(in: ["]"]).removeWhitespace()
            let query = "http://3.35.154.27:3000/v1/study/paging/list?values=\(key)"
            var studyArr: [Study] = []
            AF.request(query, headers: TerminalNetwork.headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let data = JSON(value)["data"].array {
                        for index in data {
                            let data = "\(index)".data(using: .utf8)
                            let result = try! JSONDecoder().decode(Study.self, from: data!)
                            studyArr.append(result)
                        }
                        self.remoteRequestHandler?.onStudiesRetrieved(studyArr)
                    }
                case .failure(let err):
                    print("실패", err)
                }
            }
        }
        
        /// API Cal 이후 키값 제거
        newKeyValue.removeAll()
    }
}
