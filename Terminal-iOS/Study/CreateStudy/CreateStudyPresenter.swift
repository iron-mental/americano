//
//  CreateStudyPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyPresenter: CreateStudyPresenterProtocol {
    var view: CreateStudyViewProtocol?
    var interactor: CreateStudyInteractorProtocol?
    var wireFrame: CreateStudyWireFrameProtocol?
    
    func viewDidLoad() {
        view?.setView()
    }
    
    func notionInputFinish(id: String?) {
        view?.showLoadingToNotionInput()
        interactor?.searchNotionID(id: id)
    }
    
    func everNoteInputFinish(url: String?) {
        view?.showLoadingToEvernoteInput()
        interactor?.searchEvernoteURL(url: url)
    }
    
    func URLInputFinish(url: String?) {
        view?.showLoadingToWebInput()
        interactor?.searchWebURL(url: url)
    }
    
    func clickLocationView(currentView: UIViewController) {
        wireFrame?.goToSelectLocation(view: currentView)
    }
    
    func showNotionValidResult(result: Bool) {
        view?.hideLoadingToNotionInput()
        if result {
            view?.notionValid()
        } else {
            view?.notionInvalid()
        }
    }
    
    func showEvernoteValidResult(result: Bool) {
        view?.hideLoadingToEvernoteInput()
        if result {
            view?.evernoteValid()
        } else {
            view?.evernoteInvalid()
        }
    }
    
    func showWebValidResult(result: Bool) {
        view?.hideLoadingToWebInput()
        if result {
            view?.webValid()
        } else {
            view?.webInvalid()
        }
    }
    func clickCompleteButton(study: StudyDetailPost, studyID: Int?) {
        LoadingRainbowCat.show()
        interactor?.studyCreateComplete(study: study, studyID: studyID ?? nil)
    }
    
    func studyInfoInvalid(message: String) {
        LoadingRainbowCat.hide()
        view?.studyInfoInvalid(message: message)
    }
    
    func studyInfoValid(studyID: Int) {
        LoadingRainbowCat.hide()
        view?.studyInfoValid(studyID: studyID, message: "스터디 생성이 완료되었습니다.")
    }
}
