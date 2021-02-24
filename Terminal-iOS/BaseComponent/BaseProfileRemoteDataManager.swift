//
//  BaseProfileRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/14.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import SwiftyJSON

class BaseProfileRemoteDataManager: BaseProfileRemoteDataManagerInputProtocol {
    var remoteRequestHandler: BaseProfileRemoteDataManagerOutputProtocol?
    
    func getUserInfo(userID: String) {
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
                    let result = try! JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data!)
                    self.remoteRequestHandler?.onUserInfoRetrieved(userInfo: result)
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data)
                            if result.message != nil {
                                self.remoteRequestHandler?.onUserInfoRetrieved(userInfo: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
    
    // MARK: 유저 프로젝트
    
    func getProjectList(userID: String) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.projectList(id: userID))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<[Project]>.self, from: data!)
                    self.remoteRequestHandler?.onProjectRetrieved(project: result)
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[Project]>.self, from: data)
                            if result.message != nil {
                                self.remoteRequestHandler?.onProjectRetrieved(project: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
}
