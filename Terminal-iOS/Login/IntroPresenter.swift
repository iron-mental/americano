//
//  IntroViewPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class IntroPresenter: IntroPresenterProtocol {
    var view: IntroViewProtocol?
    var interactor: IntroInteractorProtocol?
    
    func didClickedRightBarButton(input: String, state: IntroViewState) {
        switch state {
        case .emailInput:
            interactor?.checkedEmailValid(input: input)
            break
        case .pwdInput:
            break
        case .nickname:
            break
        }
    }
    
    func emailValidInfo(result: Bool) {
        <#code#>
    }
    
    func signUpValidInfo(result: Bool) {
        <#code#>
    }
    
    
}
