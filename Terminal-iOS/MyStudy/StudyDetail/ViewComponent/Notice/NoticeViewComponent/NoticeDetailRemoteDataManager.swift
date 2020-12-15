//
//  NoticeDetailRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NoticeDetailRemoteDataManager: NoticeDetailRemoteDataManagerProtocol {
    let headers: HTTPHeaders = [ "Authorization": Terminal.accessToken]
    
    func getNoticeDetail(studyID: Int, noticeID: Int, completion: @escaping ( _ result: Bool, _ data: Notice) -> Void) {

        AF.request("http://3.35.154.27:3000/v1/study/\(studyID)/notice/\(noticeID)", method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = "\(JSON(value))".data(using: .utf8)
                let result: BaseResponse<Notice> = try! JSONDecoder().decode(BaseResponse<Notice>.self, from: json!)
                guard  let notice = result.data else { return }
                completion(result.result, notice)
                break
            case .failure( _):
                break
            }
        }
    }
    
    func postNoticeRemove(studyID: Int, noticeID: Int, completion: @escaping (Bool, String) -> Void) {
        let url = "http://3.35.154.27:3000/v1/study/\(studyID)/notice/\(noticeID)"
        let headers: HTTPHeaders = [
            "Authorization" : Terminal.accessToken
        ]
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers ).responseJSON { result in
            switch result.result {
            case .success(let value):
                
                completion( true, "테스트")
                break
            case .failure( _):
                
                break
            }
        }
    }
    
}
