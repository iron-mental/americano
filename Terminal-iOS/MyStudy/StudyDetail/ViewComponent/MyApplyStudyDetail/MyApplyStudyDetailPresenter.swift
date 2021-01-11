//
//  MyApplyStudyDetailPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class MyApplyStudyDetailPresenter: MyApplyStudyDetailPresenterInputProtocol {
    var view: MyApplyStudyDetailViewProtocol?
    var interactor: MyApplyStudyDetailInteractorInputProtocol?
    var wireFrame: MyApplyStudyDetailWireFrameProtocol?
    
    func viewDidLoad(studyID: Int) {
        LoadingRainbowCat.show()
        interactor?.getMyApplyStudyDetail(studyID: studyID)
    }

}

extension MyApplyStudyDetailPresenter: MyApplyStudyDetailInteractorOutputProtocol {
    func retriveMyApplyStudyDetail(result: Bool, message: String) {
        switch result {
        case true:
            LoadingRainbowCat.hide {
                self.view?.showMyApplyStudyDetail(message: message)
            }
            break
        case false:
            LoadingRainbowCat.hide {
                self.view?.showError()
            }
            break
        }
    }
}
