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
    
    func postNotice(studyID: Int, notice: NoticePost, completion: @escaping (Bool, String) -> Void) {
        let url = URL(string: "http://3.35.154.27:3000/v1/study/\(studyID)/notice")
        
        let params: Parameters = [
            "title" : notice.title,
            "contents" : notice.contents,
            "pinned" : notice.pinned
        ]
        AF.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default ,headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(JSON(value)["result"].bool!, JSON(value)["message"].string!)
                break
            case .failure(let err):
                break
            }
        }
    }
}
