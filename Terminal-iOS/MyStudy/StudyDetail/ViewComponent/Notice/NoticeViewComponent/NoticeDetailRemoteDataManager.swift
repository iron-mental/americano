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

class NoticeDetailRemoteDataManager: NoticeDetailRemoteDataManagerInputProtocol {
    weak var interactor: NoticeDetailRemoteDataManagerOutputProtocol?
    
    func getNoticeDetail(studyID: Int, noticeID: Int) {
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
                        if result.data != nil {
                            self.interactor?.getNoticeDetailResult(result: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<Notice>.self, from: data)
                            if result.message != nil {
                                self.interactor?.getNoticeDetailResult(result: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
    
    func postNoticeRemove(studyID: Int, noticeID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeDelete(studyID: "\(studyID)", noticeID: "\(noticeID)"))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = "\(JSON(value))".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<String>.self, from: json!)
                    if result.message != nil {
                        self.interactor?.removeNoticeDetailResult(result: result)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                            if result.message != nil {
                                self.interactor?.removeNoticeDetailResult(result: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
}
