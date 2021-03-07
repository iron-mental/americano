//
//  ProfileModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileModifyPresenter: ProfileModifyPresenterProtocol {
    weak var view: ProfileModifyViewProtocol?
    var interactor: ProfileModifyInteractorInputProtocol?
    var wireFrame: ProfileModifyWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.viewDidLoad()
    }
    
    func completeImageModify(image: UIImage) {
        interactor?.completeImageModify(image: image)
    }
    
    func completeModify(profile: Profile) {
        interactor?.completeModify(profile: profile)
    }
}

extension ProfileModifyPresenter: ProfileModifyInteractorOutputProtocol {
    func didCompleteModify(result: Bool, message: String) {
        self.view?.modifyResultHandle(result: result, message: message)
    }
    
    func modifyFailed(message: String, label: String) {
        view?.hideLoading()
        view?.showError(message: message, label: label)
    }
    
    func sessionTaskError(message: String) {
        view?.hideLoading()
        view?.showError(message: message, label: nil)
    }
}
