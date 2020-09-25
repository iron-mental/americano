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
    
    func clickAddressInput() {
        print("address")
    }
    
    func didCompleteButtonClick() {
        print("complete")
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
}
