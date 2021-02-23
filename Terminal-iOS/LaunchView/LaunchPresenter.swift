//
//  LaunchPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/23.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class LaunchPresenter: LaunchPresenterProtocol {
    weak var view: LaunchViewProtocol?
    var interactor: LaunchInteractorInputProtocol?
    var wireFrame: LaunchWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.getVersionCheck()
    }
    func getRefreshTokenValid() {
        interactor?.refreshTokenCheck()
    }
}

extension LaunchPresenter: LaunchInteractorOutputProtocol {
    func versionNeedUpdate(force: VersionResultType) {
        switch force {
        case .Recommended:
            //새로운 얼럿(업데이트 추천 뷰)
            view?.showVersionUpdateAlert(alertType: .AllowUserView)
        case .Required:
            //새로운 얼럿(업데이트 강제 뷰)
            view?.showVersionUpdateAlert(alertType: .AllowUserView)
        case .notRequired: break
        }
    }
    
    func refreshTokenIsEmpty() {
        wireFrame?.replaceRootViewToIntroView()
    }
    
    func refreshTokenResult(result: Bool) {
        switch result {
        case true:
            wireFrame?.replaceRootViewToMainView()
        case false:
            wireFrame?.replaceRootViewToIntroView()
        }
    }
}
