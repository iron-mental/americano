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
    
    // MARK: 최신순 리스트 검색시 초기 배열값
    
    func retrieveLatestStudyList(category: String) {
        let params: [String: String] = [
            "category": category,
            "sort": "new"
        ]
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyList(sort: params))
            .validate(statusCode: 200...422)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data!)
                        self.remoteRequestHandler?.onStudiesLatestRetrieved(result: result)
                    } catch {
                        print(error)
                    }
                case .failure(let err):
                    print(err)
                }
            }
    }
    
    // MARK: 지역순 리스트 검색시 초기 배열값
    
    func retrieveLengthStudyList(category: String) {
        let params: [String: String] = [
            "category": category,
            "sort": "length"
        ]
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyList(sort: params))
            .validate(statusCode: 200...422)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data!)
                        self.remoteRequestHandler?.onStudiesLengthRetrieved(result: result)
                    } catch {
                        print(error)
                    }
                case .failure(let err):
                    print(err)
                }
            }
    }
    
    
    // MARK: key 값을 통한 최신순 페이징
    
    func paginationRetrieveLatestStudyList(keyValue: [Int], completion: @escaping (() -> Void)) {
        if keyValue.count > 0 {
            let key = "\(keyValue)"
                .trimmingCharacters(in: ["["])
                .trimmingCharacters(in: ["]"])
                .removeWhitespace()
            
            let params: [String: Any] = [
                "sort": "new",
                "values": key
            ]
            
            TerminalNetworkManager
                .shared
                .session
                .request(TerminalRouter.studyListForKey(key: params))
                .validate(statusCode: 200...422)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let data = "\(json)".data(using: .utf8)
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data!)
                            self.remoteRequestHandler?.onStudiesForKeyLatestRetrieved(result: result)
                            completion()
                        } catch {
                            print(error)
                        }
                    case .failure(let err):
                        print(err)
                    }
                }
        }
    }
    
    // MARK: key 값을 통한 지역순 페이징
    
    func paginationRetrieveLengthStudyList(keyValue: [Int], completion: @escaping (() -> Void)) {
        if keyValue.count > 0 {
            let key = "\(keyValue)"
                .trimmingCharacters(in: ["["])
                .trimmingCharacters(in: ["]"])
                .removeWhitespace()
            
            let params: [String: Any] = [
                "sort": "length",
                "values": key
            ]
            
            TerminalNetworkManager
                .shared
                .session
                .request(TerminalRouter.studyListForKey(key: params))
                .validate(statusCode: 200...422)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let data = "\(json)".data(using: .utf8)
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data!)
                            self.remoteRequestHandler?.onStudiesForKeyLengthRetrieved(result: result)
                            completion()
                        } catch {
                            print(error)
                        }
                    case .failure(let err):
                        print(err)
                    }
                }
        }
    }
}
