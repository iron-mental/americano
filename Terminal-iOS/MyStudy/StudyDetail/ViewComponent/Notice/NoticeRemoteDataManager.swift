//
//  NoticeRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NoticeRemoteDataManager: NoticeRemoteDataManagerProtocol {
    
    
    
    let headers: HTTPHeaders = [ "Authorization": Terminal.accessToken]
    
    func getNoticeList(studyID: Int, completion: @escaping (_: Bool, _: NoticeList?, _: String?) -> Void) {
        
        AF.request("http://3.35.154.27:3000/v1/study/\(studyID)/notice",
                   method: .get,headers: headers).responseJSON(completionHandler: { [self] response in
                    
                    switch response.result {
                    case .success(let value):
                        if JSON(value)["result"].bool! {
                        let json = "\(JSON(value))".data(using: .utf8)
                        let result: NoticeList = try! JSONDecoder().decode(NoticeList.self, from: json!)
                            completion(true, result, nil)
                        } else {
                            completion(false, nil, JSON(value)["message"].string!)
                        }
                    case .failure(let value):
                        print("에러@@@@@@@@@@@@2")
                        print(value)
                    }
                    
                   })
    }
    func getNoticeDetail(studyID: Int, noticeID: Int, completion: @escaping (Bool, Notice) -> Void) {
    
        AF.request("http://3.35.154.27:3000/v1/study/\(studyID)/notice/\(noticeID)", method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = "\(JSON(value))".data(using: .utf8)
                let result: BaseResponse<Notice> = try! JSONDecoder().decode(BaseResponse<Notice>.self, from: json!)
                print("이게 상세로 떨어지는거",result)
                guard  let notice = result.data else { return }
                completion(result.result, notice)

                break
            case .failure(let err):
                break
            }
        }
    }
}
