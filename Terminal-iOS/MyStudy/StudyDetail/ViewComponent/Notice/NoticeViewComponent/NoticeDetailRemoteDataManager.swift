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
    
    func getNoticeDetail(studyID: Int, noticeID: Int, completion: @escaping ( _ result: Bool, _ data: Notice) -> Void) {
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeDetail(studyID: "\(studyID)", noticeID: "\(noticeID)"))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = "\(JSON(value))".data(using: .utf8)
                    let result: BaseResponse<Notice> = try! JSONDecoder().decode(BaseResponse<Notice>.self, from: json!)
                    guard let notice = result.data else { return }
                    completion(result.result, notice)
                    break
                case .failure( _):
                    break
                }
            }
    }
    
    func postNoticeRemove(studyID: Int, noticeID: Int, completion: @escaping (Bool, String) -> Void) {
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeDelete(studyID: "\(studyID)", noticeID: "\(noticeID)"))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    completion( true, "테스트")
                    break
                case .failure( _):
                    break
                }
            }
    }
}
