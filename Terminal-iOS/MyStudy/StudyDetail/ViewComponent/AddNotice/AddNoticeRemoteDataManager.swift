//
//  AddNoticeRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class AddNoticeRemoteDataManager: AddNoticeRemoteDataManagerProtocol {
    
    func postNotice(studyID: Int,
                    notice: NoticePost,
                    completion: @escaping (BaseResponse<EditNoticeResult>) -> Void) {
        
        let params: [String: Any] = [
            "title": notice.title,
            "contents": notice.contents,
            "pinned": notice.pinned
        ]
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeCreate(studyID: "\(studyID)", notice: params))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<EditNoticeResult>.self, from: data!)
                        if result.data != nil {
                            completion(result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<EditNoticeResult>.self, from: data)
                            if result.message != nil {
                                completion(result)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
    
    
    func putNotice(studyID: Int,
                   notice: NoticePost,
                   noticeID: Int,
                   completion: @escaping (BaseResponse<String>) -> Void) {
        
        let params: [String: Any] = [
            "title": notice.title,
            "contents": notice.contents,
            "pinned": notice.pinned
        ]
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeUpdate(studyID: String(studyID),
                                                 noticeID: String(noticeID),
                                                 notice: params))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data!)
                        if result.message != nil {
                            completion(result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                            if result.message != nil {
                                completion(result)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
}
