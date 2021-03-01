//
//  ApplyUserDetailRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/15.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ApplyUserDetailRemoteDataManager: ApplyUserDetailRemoteDataManagerInputProtocol {
   weak var interactor: ApplyUserDetailRemoteDataManagerOutputProtocol?
    
    func getApplyUserInfo(studyID: Int, applyID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyUserDetail(studyID: studyID, applyID: applyID))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<ApplyUserInfo>.self, from: data)
                        self.interactor?.onUserInfoRetrieved(userInfo: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<ApplyUserInfo>.self, from: data)
                            self.interactor?.onUserInfoRetrieved(userInfo: result)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
    
    func postApplyStatus(studyID: Int, applyID: Int, status: Bool) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyDetermine(studyID: studyID, applyID: applyID, status: status))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                        if result.message != nil {
                            self.interactor?.onApplyStatusRetrieved(response: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                            if result.message != nil {
                                self.interactor?.onApplyStatusRetrieved(response: result)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
}
