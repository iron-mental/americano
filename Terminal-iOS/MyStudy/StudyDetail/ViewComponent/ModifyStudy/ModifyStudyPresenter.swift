//
//  ModifyStudyPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ModifyStudyPresenter: ModifyStudyPresenterProtocol {
    weak var view: ModifyStudyViewProtocol?
    var interactor: ModifyStudyInteractorInputProtocol?
    var wireFrame: ModifyStudyWireFrameProtocol?
    
    func clickLocationView(currentView: UIViewController) {
        wireFrame?.goToSelectLocation(view: currentView)
    }
    
    func completButtonDidTap(studyID: Int, study: StudyDetailPost) {
        LoadingRainbowCat.show()
        interactor?.putStudyInfo(studyID: studyID, study: study)
    }
}

extension ModifyStudyPresenter: ModifyStudyInteractorOutputProtocol {
    func putStudyInfoResult(result: Bool, message: String) {
        switch result {
        case true:
            LoadingRainbowCat.hide {
                
                self.view?.showResult(message: message)
            }
        case false:
            LoadingRainbowCat.hide {
                
                self.view?.showError()
            }
        }
    }
}
