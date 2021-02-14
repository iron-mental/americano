//
//  MyApplyListPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class MyApplyListPresenter: MyApplyListPresenterProtocol {
    weak var view: MyApplyListViewProtocol?
    var interactor: MyApplyListInteractorInputProtocol?
    var wireFrame: MyApplyListWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.getApplyList()
    }
    
    func showStudyDetail(applyStudy: ApplyStudy) {
        wireFrame?.presentStudyDetailScreen(from: view!, applyStudy: applyStudy)
    }
}

extension MyApplyListPresenter: MyApplyListInteractorOutputProtocol {
    func didRetrieveStudies(result: BaseResponse<[ApplyStudy]>) {
        switch result.result {
        case true:
            guard let list = result.data else { return }
            view?.hideLoading()
            self.view?.showStudyList(studies: list)
        case false:
            guard let message = result.message else { return }
            view?.hideLoading()
            self.view?.showError(message: message)
        }
    }
}
