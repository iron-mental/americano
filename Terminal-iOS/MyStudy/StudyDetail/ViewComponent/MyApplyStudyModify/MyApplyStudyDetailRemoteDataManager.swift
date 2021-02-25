//
//  MyApplyStudyDetailRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class MyApplyStudyModifyRemoteDataManager: MyApplyStudyModifyRemoteDataManagerInputProtocol {
    weak var interactor: MyApplyStudyModifyRemoteDataManagerOutputProtocol?
    
    func getMyApplyStudyDetail(studyID: Int, userID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyStudyDetail(studyID: studyID, userID: userID))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<ApplyUserResult>.self, from: data)
                        if let data = result.data {
                            self.interactor?.retriveMyApplyStudyDetail(result: result.result, data: data, message: nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<ApplyUserResult>.self, from: data)
                            if let message = result.message {
                                self.interactor?.retriveMyApplyStudyDetail(result: result.result, data: nil, message: message)
                            }
                        } catch {
                            print("error")
                        }
                    }
                }
            }
    }
    
    func putNewApplyMessage(studyID: Int, applyID: Int, newMessage: String) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyModify(studyID: studyID, applyID: applyID, message: newMessage))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                        if let message = result.message {
                            self.interactor?.retriveModifyApplyMessage(result: result.result, message: message)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                            if let message = result.message {
                                self.interactor?.retriveModifyApplyMessage(result: result.result, message: message)
                            }
                        } catch {
                            print("error")
                        }
                    }
                }
            }
    }
}
