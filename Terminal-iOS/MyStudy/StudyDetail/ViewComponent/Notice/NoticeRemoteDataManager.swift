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
    
    func getNoticeList(studyID: Int, completion: @escaping ( _ result: Bool, _ data: [Notice]?, _ message: String?) -> Void) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeList(studyID: "\(studyID)"))
            .responseJSON{ response in
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
            }
    }
    
    func getNoticeListPagination(studyID: Int, noticeListIDs: [Int], completion: @escaping (Bool, [Notice]?, String?) -> Void) {
        var valuesString = ""
        noticeListIDs.forEach { valuesString += "\($0)," }
        valuesString.remove(at: valuesString.index(before: valuesString.endIndex))
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeListForKey(studyID: "\(studyID)", value: valuesString))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if JSON(value)["result"].bool! {
                        let json = "\(JSON(value))".data(using: .utf8)
                        let result: BaseResponse<[Notice]> = try! JSONDecoder().decode(BaseResponse<[Notice]>.self, from: json!)
                        completion(true, result.data, nil)
                    } else {
                        completion(false, nil, JSON(value)["message"].string!)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
