//
//  LaunchRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/23.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class LaunchRemoteDataManager: LaunchRemoteDataManagerInputProtocol {
    weak var interactor: LaunchRemoteDataManagerOutputProtocol?
    
    func getVersionCheck(version: String) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.versionCheck(version: version))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<VersionResult>.self, from: data)
                        self.interactor?.getVersionResult(result: result)
                    } catch {
                        //서버와 형식이 맞지않아 임시로 써놓음
                        self.interactor?.getVersionResult(result: BaseResponse(result: true,
                                                                               type: nil,
                                                                               label: nil,
                                                                               message: nil,
                                                                               code: nil,
                                                                               data: VersionResult(latestVersion: "1.0",
                                                                                                   force: "0")))
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<VersionResult>.self, from: data)
                            if result.message != nil {
                                self.interactor?.getVersionResult(result: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
    
    func getRefreshTokenValid(userID: String) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userInfo(id: userID))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data)
                        self.interactor?.getRefreshTokenResult(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data)
                            if result.message != nil {
                                self.interactor?.getRefreshTokenResult(result: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
}
