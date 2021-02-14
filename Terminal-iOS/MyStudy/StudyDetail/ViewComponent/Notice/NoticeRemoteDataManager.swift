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
    func getNoticeList(studyID: Int,
                       completion: @escaping (_ result: BaseResponse<[Notice]>) -> Void) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeList(studyID: "\(studyID)"))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[Notice]>.self, from: data!)
                        if result.data != nil {
                            completion(result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[Notice]>.self, from: data)
                            if result.message != nil {
                                completion(result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
    
    func getNoticeListPagination(studyID: Int,
                                 noticeListIDs: [Int],
                                 completion: @escaping (_: Bool,
                                                        _: [Notice]?,
                                                        _: String?) -> Void) {
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
                        let json = JSON(value)
                        let data = "\(json)".data(using: .utf8)
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[Notice]>.self, from: data!)
                            completion(true, result.data, nil)
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        completion(false, nil, JSON(value)["message"].string!)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                            if result.message != nil {
                                completion(result.result, nil, result.message)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
}
