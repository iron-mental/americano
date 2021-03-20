//
//  StudyListRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire

final class StudyListRemoteDataManager: StudyListRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: StudyListRemoteDataManagerOutputProtocol?
    
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
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                        self.remoteRequestHandler?.onStudiesLatestRetrieved(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.remoteRequestHandler?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
                            if let data = response.data {
                                do {
                                    let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                                    self.remoteRequestHandler?.onStudiesLatestRetrieved(result: result)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
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
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                        self.remoteRequestHandler?.onStudiesLengthRetrieved(result: result)
                    } catch {
                        print(error)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.remoteRequestHandler?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
                            if let data = response.data {
                                do {
                                    let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                                    self.remoteRequestHandler?.onStudiesLengthRetrieved(result: result)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
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
                "option": "default",
                "values": key
            ]
            
            TerminalNetworkManager
                .shared
                .session
                .request(TerminalRouter.studyListForKey(key: params))
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                            self.remoteRequestHandler?.onStudiesForKeyLatestRetrieved(result: result)
                            completion()
                        } catch {
                            print(error.localizedDescription)
                        }
                    case .failure(let err):
                        if let err = err.asAFError {
                            switch err {
                            case .sessionTaskFailed:
                                self.remoteRequestHandler?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                            default:
                                if let data = response.data {
                                    do {
                                        let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                                        self.remoteRequestHandler?.onStudiesForKeyLengthRetrieved(result: result)
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                        }
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
                "option": "distance",
                "values": key
            ]
            
            TerminalNetworkManager
                .shared
                .session
                .request(TerminalRouter.studyListForKey(key: params))
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                            self.remoteRequestHandler?.onStudiesForKeyLengthRetrieved(result: result)
                            completion()
                        } catch {
                            print(error.localizedDescription)
                        }
                    case .failure(let err):
                        if let err = err.asAFError {
                            switch err {
                            case .sessionTaskFailed:
                                self.remoteRequestHandler?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                            default:
                                if let data = response.data {
                                    do {
                                        let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                                        self.remoteRequestHandler?.onStudiesForKeyLengthRetrieved(result: result)
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                        }
                        
                    }
                }
        }
    }
}
