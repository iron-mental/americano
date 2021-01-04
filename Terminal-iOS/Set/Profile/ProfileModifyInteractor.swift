//
//  ProfileModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import SwiftyJSON

class ProfileModifyInteractor: ProfileModifyInteractorInputProtocol {
    var presenter: ProfileModifyInteractorOutputProtocol?
    var remoteDataManager: ProfileModifyRemoteDataManagerInputProtocol?
    
    func viewDidLoad() {
        remoteDataManager?.authCheck {}
    }
    
    func completeModify(profile: Profile) {
        let params: [String: String] = [
            "nickname": profile.nickname,
            "introduce": profile.introduction
        ]
        
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userInfoUpdate(id: userID, profile: params))
            .validate(statusCode: 200..<500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(JSON(value))
                case .failure(let error):
                    print(error)
                }
            }
//        let uploadImage = userInfo.image!.jpegData(compressionQuality: 0.5)
//        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
//
//        TerminalNetworkManager
//            .shared
//            .session
//            .upload(multipartFormData: { multipartFormData in
//                for (key, value) in params {
//                    let data = "\(value)".data(using: .utf8)!
//                    multipartFormData.append(data,
//                                             withName: key,
//                                             mimeType: "text/plain")
//                }
//                multipartFormData.append(uploadImage!,
//                                         withName: "image",
//                                         fileName: "\(userInfo.nickname!).jpg",
//                                         mimeType: "image/jpeg")
//            }, with: TerminalRouter.userInfoUpdate(id: userID))
//            .validate(statusCode: 200..<299)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    print("여기닷:",JSON(value))
//                case .failure(let err):
//                    print(err)
//                }
//            }
        
        
    }
}

extension ProfileModifyInteractor: ProfileModifyRemoteDataManagerOutputProtocol {
    
}
