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
                    let result = JSON(value)["result"].bool!
                    if result {
                        let noticeID = JSON(value)["data"]["notice_id"].int!
                        completion(result, noticeID)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    
    func putNotice(studyID: Int, notice: NoticePost, noticeID: Int, completion: @escaping (Bool, Int) -> Void) {
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
                    let result = JSON(value)["result"].bool!
                    if result {
                        completion(result, noticeID)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
