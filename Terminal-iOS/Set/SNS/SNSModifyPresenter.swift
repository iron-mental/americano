//
//  SNSModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

final class SNSModifyPresenter: SNSModifyPresenterProtocol {
    weak var view: SNSModifyViewProtocol?
    var interactor: SNSModifyInteractorInputProtocol?
    var wireFrame: SNSModifyWireFrameProtocol?
    
    func completeModify(github: String, linkedin: String, web: String) {
        self.interactor?.completeModify(github: github, linkedin: linkedin, web: web)
    }
}

extension SNSModifyPresenter: SNSModifyInteractorOutputProtocol {
    func didCompleteModify(result: Bool, message: String) {
        self.view?.modifyResultHandle(result: result, message: message)
    }
    
    func modifyError(label: String?, message: String) {
        view?.showError(label: label, message: message)
    }
    
    func sessionTaskError(message: String) {
        view?.hideLoading()
        view?.showError(label: nil, message: message)
    }
}
