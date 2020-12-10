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
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeList(studyID: "\(studyID)"))
            .responseJSON(completionHandler: { response in
             switch response.result {
             case .success(let value):
                 if JSON(value)["result"].bool! {
                     let json = "\(JSON(value))".data(using: .utf8)
                     let result = try! JSONDecoder().decode(BaseResponse<[Notice]>.self, from: json!)
                     completion(true, result.data, nil)
                 } else {
                     completion(false, nil, JSON(value)["message"].string!)
                 }
             case .failure(let error):
                 print(error)
             }
            })
        
        
//        AF.request("http://3.35.154.27:3000/v1/study/\(studyID)/notice",
//                   method: .get,headers: headers).responseJSON(completionHandler: { response in
//                    switch response.result {
//                    case .success(let value):
//                        if JSON(value)["result"].bool! {
//                            let json = "\(JSON(value))".data(using: .utf8)
//                            let result = try! JSONDecoder().decode(BaseResponse<[Notice]>.self, from: json!)
//                            completion(true, result.data, nil)
//                        } else {
//                            completion(false, nil, JSON(value)["message"].string!)
//                        }
//                    case .failure(let error):
//                        print(error)
//                    }
//                   })
    }
    
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
