//
//  ProjectModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/01.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

final class ProjectModifyPresenter: ProjectModifyPresenterProtocol {
    weak var view: ProjectModifyViewProtocol?
    var interactor: ProjectModifyInteractorInputProtocol?
    var wireFrame: ProjectModifyWireFrameProtocol?
    
    func completeModify(project: [Project]) {
        interactor?.completeModify(project: project)
    }
}

extension ProjectModifyPresenter: ProjectModifyInteractorOutputProtocol {
    func didCompleteModify(result: Bool, message: String) {
        self.view?.modifyResultHandle(result: result, message: message)
    }
    
    func sessionTaskError(message: String) {
        self.view?.hideLoading()
        self.view?.showError(message: message)
    }
    
    func modifyFailed(message: String, label: String) {
        self.view?.hideLoading()
        self.view?.showError(message: message, label: label)
    }
}
