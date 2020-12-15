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
    
    func postNotice(studyID: Int, notice: NoticePost, completion: @escaping (Bool, Int) -> Void) {
        let params: [String: String] = [
            "title": notice.title,
            "contents": notice.contents,
            "pinned": "\(notice.pinned)"
        ]
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.createNotice(studyID: "\(studyID)", notice: params))
            .validate(statusCode: 200..<299)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let result = JSON(value)["result"].bool!
                    if result {
                        let noticeID = JSON(value)["data"]["notice_id"].int!
                        completion(result, noticeID)
                    }
                    break
                case .failure( _):
                    break
                }
            }
    }
    
    
    func putNotice(studyID: Int, notice: NoticePost, noticeID: Int, completion: @escaping (Bool, Int) -> Void) {
        let params: [String: String] = [
            "title": notice.title,
            "contents": notice.contents,
            "pinned": "\(notice.pinned)"
        ]
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeUpdate(studyID: String(studyID),
                                                 noticeID: String(noticeID),
                                                 notice: params))
            .validate(statusCode: 200..<299)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let result = JSON(value)["result"].bool!
                    if result {
                        completion(result, noticeID)
                    }
                    break
                case .failure( _):
                    break
                }
            }
    }
}
