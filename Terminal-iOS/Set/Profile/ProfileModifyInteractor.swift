//
//  ProfileModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ProfileModifyInteractor: ProfileModifyInteractorInputProtocol {
    weak var presenter: ProfileModifyInteractorOutputProtocol?
    var remoteDataManager: ProfileModifyRemoteDataManagerInputProtocol?
    
    var imageResult: Bool = true
    var nicknameResult: Bool = true
    
    func viewDidLoad() {
        remoteDataManager?.authCheck {}
    }
    
    func completeImageModify(image: UIImage) {
        remoteDataManager?.retrieveImageModify(image: image)
        imageResult = false
    }
        
    func completeModify(profile: Profile) {
        var params: [String: String] = [
            "introduce": profile.introduction
        ]
        
        // 닉네임이 비어있으면 닉네임 변경되지 않음, but 변경되었으면 파라미터 추가
        if !profile.nickname.isEmpty {
            params.updateValue(profile.nickname, forKey: "nickname")
        }
        remoteDataManager?.retrieveNicknameModify(profile: params)
        nicknameResult = false
    }
}

extension ProfileModifyInteractor: ProfileModifyRemoteDataManagerOutputProtocol {
    func mergeProfileModifyResult() {
        if imageResult && nicknameResult {
            let message = "프로필 수정 성공"
            self.presenter?.didCompleteModify(result: true, message: message)
            self.imageResult = false
            self.nicknameResult = false
        } else {
            print("수정 실패")
        }
    }
    
    func imageModifyRetrieved(result: BaseResponse<Bool>) {
        switch result.result {
        case true:
            self.imageResult = result.result
            mergeProfileModifyResult()
        case false:
            self.imageResult = result.result
            mergeProfileModifyResult()
        }
    }
    
    func nicknameModifyRetrieved(result: BaseResponse<Bool>) {
        switch result.result {
        case true:
            self.nicknameResult = result.result
            mergeProfileModifyResult()
        case false:
            guard let message = result.message else { return }
            presenter?.modifyFailed(message: message)
        }
    }
    
    func sessionTaskError(message: String) {
        presenter?.sessionTaskError(message: message)
    }
}
