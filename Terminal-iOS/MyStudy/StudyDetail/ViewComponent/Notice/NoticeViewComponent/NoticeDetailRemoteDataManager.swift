//
//  NoticeDetailRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class NoticeDetailRemoteDataManager: NoticeDetailRemoteDataManagerInputProtocol {
    weak var interactor: NoticeDetailRemoteDataManagerOutputProtocol?
    
    func getNoticeDetail(studyID: Int, noticeID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeDetail(studyID: "\(studyID)", noticeID: "\(noticeID)"))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Notice>.self, from: data)
                        if result.data != nil {
                            self.interactor?.getNoticeDetailResult(result: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.interactor?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
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
            }
    }
    
    func postNoticeRemove(studyID: Int, noticeID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.noticeDelete(studyID: "\(studyID)", noticeID: "\(noticeID)"))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                        if result.message != nil {
                            self.interactor?.removeNoticeDetailResult(result: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.interactor?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
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
    }
}
