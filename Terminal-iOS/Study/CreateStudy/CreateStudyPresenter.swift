//
//  CreateStudyPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyPresenter: CreateStudyPresenterProtocols {
    
    
    var view: CreateStudyViewProtocols?
    var interactor: CreateStudyInteractorProtocols?
    var wireFrame: CreateStudyWireFrameProtocols?
    
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
    func clickCompleteButton(study: StudyDetailPost, state: WriteStudyViewState, studyID: Int?) {
        view?.loading()
        interactor?.studyCreateComplete(study: study, state: state, studyID: studyID ?? nil)
    }
    
    func studyInfoInvalid(message: String) {
        view?.studyInfoInvalid(message: message)
    }
    
    func studyInfoValid(message: String) {
        view?.studyInfoValid(message: message)
    }
    func viewDidTap(textView: UIView, viewMinY: CGFloat, viewMaxY: CGFloat) {
        interactor?.viewDidTap(textView: textView, viewMinY: viewMinY, viewMaxY: viewMaxY)
    }
    
    func viewDidTapResult(result: Bool, topOrBottom: Bool?) {
        switch result {
        case true:
            topOrBottom == true ? view?.viewToTop() : view?.viewToBottom()
        case false:
            print("클릭된 뷰가 움직일 필요가 없답니다")
        }
    }
}
