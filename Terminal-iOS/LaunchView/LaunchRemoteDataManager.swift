//
//  LaunchRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/23.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON

class LaunchRemoteDataManager: LaunchRemoteDataManagerInputProtocol {
    weak var interactor: LaunchRemoteDataManagerOutputProtocol?
    
    func getVersionCheck(version: String) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.versionCheck(version: version))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<VersionResult>.self, from: data!)
                        self.interactor?.getVersionResult(result: result)
                    } catch {
                        print(error.localizedDescription)
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
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data!)
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
