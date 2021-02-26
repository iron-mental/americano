//
//  FindPasswordInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

final class FindPasswordInteractor: FindPasswordInteractorInputProtocol {
    var presenter: FindPasswordInteractorOutputProtocol?
    var remoteDataManager: FindPasswordRemoteDataManagerInputProtocol?
    
    func resetRequest(email: String) {
        if email.isEmpty {
            self.presenter?.resetResponse(result: false, message: "이메일을 입력해주세요.")
        } else if !email.contains("@") || !email.contains(".") {
            self.presenter?.resetResponse(result: false, message: "이메일 형식이 맞지 않습니다.")
        } else {
            self.remoteDataManager?.resetPassword(email: email)
        }
    }
}

extension FindPasswordInteractor: FindPasswordRemoteDataManagerOutputProtocol {
    func resetResponse(result: BaseResponse<Bool>) {
        self.presenter?.resetResponse(result: result.result, message: result.message!)
    }
}
