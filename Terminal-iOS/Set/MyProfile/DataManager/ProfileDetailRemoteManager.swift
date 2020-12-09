//
//  ProfileDetailRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/26.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class ProfileDetailRemoteManager: ProfileDetailRemoteDataManagerInputProtocol {
    var remoteRequestHandler: ProfileDetailRemoteDataManagerOutputProtocol?
    
    // MARK: 유저정보
    
    func getUserInfo() {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userInfo(id: userID))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data!)
                    self.remoteRequestHandler?.onUserInfoRetrieved(userInfo: result)
                case .failure(let err):
                    print("실패")
                    print(err)
                }
            }
    }
    
    // MARK: 유저 프로젝트
    
    func getProjectList() {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.projectList(id: userID))
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = "\(json)".data(using: .utf8)
                let result = try! JSONDecoder().decode(BaseResponse<[Project]>.self, from: data!)
                self.remoteRequestHandler?.onProjectRetrieved(project: result)
            case .failure(let err):
                print("실패")
                print(err)
            }
        }
    }
}
