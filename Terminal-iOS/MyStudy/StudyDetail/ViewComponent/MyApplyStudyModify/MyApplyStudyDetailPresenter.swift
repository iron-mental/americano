//
//  MyApplyStudyModifyPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class MyApplyStudyModifyPresenter: MyApplyStudyModifyPresenterInputProtocol {
    weak var view: MyApplyStudyModifyViewProtocol?
    var interactor: MyApplyStudyModifyInteractorInputProtocol?
    var wireFrame: MyApplyStudyModifyWireFrameProtocol?
    
    func viewDidLoad(studyID: Int) {
        LoadingRainbowCat.show()
        interactor?.getMyApplyStudyDetail(studyID: studyID)
    }
    
    func admitButtonDidTap(newMessage: String) {
        LoadingRainbowCat.show()
        interactor?.putNewApplyMessage(newMessage: newMessage)
    }
}

extension MyApplyStudyModifyPresenter: MyApplyStudyModifyInteractorOutputProtocol {
    func retriveModifyApplyMessage(result: Bool, message: String) {
        switch result {
        case true:
            LoadingRainbowCat.hide {
                self.view?.showModifyApplyMessageResult(message: message)
            }
        case false:
            LoadingRainbowCat.hide {
                self.view?.showError(message: message)
            }
        }
    }
    
    func retriveMyApplyStudyDetail(result: Bool, message: String) {
        switch result {
        case true:
            LoadingRainbowCat.hide {
                self.view?.showMyApplyStudyDetail(message: message)
            }
        case false:
            LoadingRainbowCat.hide {
                self.view?.showError(message: message)
            }
        }
    }   
}
