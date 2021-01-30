//
//  ProfileModifyRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class ProfileModifyRemoteManager: ProfileModifyRemoteDataManagerInputProtocol {
    var remoteRequestHandler: ProfileModifyRemoteDataManagerOutputProtocol?
    
    func authCheck(completion: @escaping () -> Void) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userInfo(id: userID))
            .validate(statusCode: 200...400)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data!)
                        if result.result { completion() }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func retrieveImageModify(image: UIImage) {
        let uploadImage = image.jpegData(compressionQuality: 0.2)!
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .upload(multipartFormData: { multipartFormData in
                multipartFormData.append(uploadImage,
                                         withName: "image",
                                         fileName: "testImage.jpg",
                                         mimeType: "image/jpeg")
            }, with: TerminalRouter.userImageUpdate(id: userID))
            .validate(statusCode: 200...400)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                        self.remoteRequestHandler?.imageModifyRetrieved(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func retrieveNicknameModify(profile: [String: String]) {
        let params: [String: String] = profile
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userInfoUpdate(id: userID, profile: params))
            .validate(statusCode: 200...400)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                        self.remoteRequestHandler?.nicknameModifyRetrieved(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    let data = response.data
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                        self.remoteRequestHandler?.nicknameModifyRetrieved(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
    }
}
