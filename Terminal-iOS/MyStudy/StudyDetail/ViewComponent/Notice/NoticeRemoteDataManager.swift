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
    func getNoticeList(studyID: Int, completion: @escaping ( _ result: Bool, _ data: [Notice]?, _ message: String?) -> Void) {
        AF.request("http://3.35.154.27:3000/v1/study/\(studyID)/notice",
                   method: .get,headers: headers).responseJSON(completionHandler: { [self] response in
                    switch response.result {
                    case .success(let value):
                        if JSON(value)["result"].bool! {
                            let json = "\(JSON(value))".data(using: .utf8)
                            let result: BaseResponse<[Notice]> = try! JSONDecoder().decode(BaseResponse<[Notice]>.self, from: json!)
                            completion( true, result.data, nil)
                        } else {
                            completion(false, nil, JSON(value)["message"].string!)
                        }
                    case .failure(let value):
                        print("에러@@@@@@@@@@@@2")
                        print(value)
                    }
                   })
    }
//    func getNoticeDetail(studyID: Int, noticeID: Int, completion: @escaping ( _ result: Bool, _ data: Notice) -> Void) {
//        
//        AF.request("http://3.35.154.27:3000/v1/study/\(studyID)/notice/\(noticeID)", method: .get, headers: headers).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = "\(JSON(value))".data(using: .utf8)
//                let result: BaseResponse<Notice> = try! JSONDecoder().decode(BaseResponse<Notice>.self, from: json!)
//                guard  let notice = result.data else { return }
//                completion(result.result, notice)
//                break
//            case .failure( _):
//                break
//            }
//        }
//    }
    func getNoticeListPagination(studyID: Int, noticeListIDs: [Int], completion: @escaping ( _ result: Bool, _ data: [Notice]?, _ message: String?) -> Void) {
        var valuesString = ""
        noticeListIDs.forEach {
            valuesString += "\($0),"
        }
        valuesString.remove(at: valuesString.index(before: valuesString.endIndex))
        let url = URL(string: "http://3.35.154.27:3000/v1/study/\(studyID)/notice/paging/list?values=\(valuesString)")
        AF.request(url!, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                if JSON(value)["result"].bool! {
                    let json = "\(JSON(value))".data(using: .utf8)
                    let result: BaseResponse<[Notice]> = try! JSONDecoder().decode(BaseResponse<[Notice]>.self, from: json!)
                    completion(true, result.data, nil)
                } else {
                    completion(false, nil, JSON(value)["message"].string!)
                }
                break
            case .failure(let err):
                print(err)
                break
            }
        }
    }
}
