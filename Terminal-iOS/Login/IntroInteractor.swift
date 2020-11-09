//
//  IntroInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class IntroInteractor: IntroInteractorProtocol {
    var presenter: IntroPresenterProtocol?
    var remoteDataManager: IntroRemoteDataManagerProtocol?
    
    func checkedEmailValid(input: String) {
        
        //이곳에서 이메일 유효성 검사를 마친 뒤 통과하면 이걸 해야댐
        remoteDataManager?.getEmailValidInfo(input: input)
    }
    
    func signUpValid() {
        <#code#>
    }
}
