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
    func getNoticeDetail(studyID: Int,
                         noticeID: Int,
                         completion: @escaping (_ result: Bool, _ data: Notice) -> Void) {
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeDetail(studyID: "\(studyID)", noticeID: "\(noticeID)"))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Notice>.self, from: data!)
                        guard let notice = result.data else { return }
                        completion(result.result, notice)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func postNoticeRemove(studyID: Int,
                          noticeID: Int,
                          completion: @escaping (_: Bool, _: String) -> Void) {
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeDelete(studyID: "\(studyID)", noticeID: "\(noticeID)"))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = "\(JSON(value))".data(using: .utf8)
                    let result: BaseResponse<Notice> = try! JSONDecoder().decode(BaseResponse<Notice>.self, from: json!)
                    guard let message = result.message else { return }
                    completion(true, message)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
