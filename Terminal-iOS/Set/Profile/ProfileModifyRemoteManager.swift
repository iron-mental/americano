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

final class ProfileModifyRemoteManager: ProfileModifyRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: ProfileModifyRemoteDataManagerOutputProtocol?
    
    func authCheck(completion: @escaping () -> Void) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
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
                        if result.result { completion() }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.remoteRequestHandler?
                                .sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default: break
                        }
                    }
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
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                        self.remoteRequestHandler?.nicknameModifyRetrieved(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.remoteRequestHandler?
                                .sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
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
    }
    
    func retrieveImageModify(image: UIImage, profileExistence: Bool) {
        let uploadImage = image.jpegData(compressionQuality: 0.2)!
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .upload(multipartFormData: { multipartFormData in
                if profileExistence {
                    multipartFormData.append(uploadImage,
                                             withName: "image",
                                             fileName: "testImage.jpg",
                                             mimeType: "image/jpeg")
                } else {
                    multipartFormData.append("".data(using: .utf8)!,
                                             withName: "image",
                                             mimeType: "text/plain")
                }
            }, with: TerminalRouter.userImageUpdate(id: userID))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                        self.remoteRequestHandler?.imageModifyRetrieved(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.remoteRequestHandler?
                                .sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
                            if let data = response.data {
                                do {
                                    let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                                    if result.message != nil {
                                        self.remoteRequestHandler?.imageModifyRetrieved(result: result)
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
