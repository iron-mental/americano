//
//  StudyMainPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyMainPresenter: StudyMainPresenterProtocol {
    
    var view: StudyMainViewProtocol?
    var wireFrame: StudyMainWireFrameProtocol?
    var interactor: StudyMainInteractorProtocol?

    func viewDidLoad() {
        view?.showLoading()
        interactor?.searchCategory()
    }
    func goToSearchStudy() {
    }
    func didClickedCreateButton() {
        view?.categoryDownAnimate()
    }
    func goToCreateStudy(category: String) {
        wireFrame?.goToSelectCategory(from: view!, category: category)
        view?.categoryUpAnimate()
    }
    func didSearchCategory(category: String) {
        view?.hideLoading()
        view?.showCategory(category: category)
    }
}
