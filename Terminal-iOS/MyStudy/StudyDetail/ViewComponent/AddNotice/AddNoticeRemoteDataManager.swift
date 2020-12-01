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
        
    let headers: HTTPHeaders = [ "Authorization": Terminal.accessToken]
    
    
    func postNotice(studyID: Int, notice: NoticePost, completion: @escaping (Bool, Int) -> Void) {
        let url = URL(string: "http://3.35.154.27:3000/v1/study/\(studyID)/notice")
        let params: Parameters = [
            "title" : notice.title,
            "contents" : notice.contents,
            "pinned" : notice.pinned
        ]
        AF.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default ,headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let result = JSON(value)["result"].bool!
                if result {
                    print(JSON(value))
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
        let url = URL(string: "http://3.35.154.27:3000/v1/study/\(studyID)/notice/\(noticeID)")
        let params: Parameters = [
            "title" : notice.title,
            "contents" : notice.contents,
            "pinned" : notice.pinned
        ]
        
        AF.request(url!, method: .put, parameters: params, encoding: JSONEncoding.default ,headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let result = JSON(value)["result"].bool!
                if result {
                    print(JSON(value))
//                    print(JSON(value)["message"].string!)
                    completion(result, noticeID)
                }
                break
            case .failure( _):
                break
            }
        }
    }

}
