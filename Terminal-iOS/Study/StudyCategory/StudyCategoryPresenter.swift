//
//  StudyCategoryPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class StudyCategoryPresenter: StudyCategoryPresenterProtocol {
    var view: StudyCategoryViewProtocol?
    var interactor: StudyCategoryInteractorInputProtocol?
    var wireFrame: StudyCategoryWireFrameProtocol?
    
    func viewDidLoad() {
//        view?.showLoading()
        interactor?.retrieveStudyCategory()
    }
    
    func showStudyListDetail(category: String) {
        wireFrame?.presentStudyListScreen(from: view!, category: category)
    }
    
    func goToCreateStudy(category: [Category]) {
        wireFrame?.goToSelectCategory(from: view!, category: category)
        view?.categoryUpAnimate()
    }
    
    func didClickedCreateButton() {
        view?.categoryDownAnimate()
    }

    func goToSearchStudy() {
        wireFrame?.goToSearchStudy(from: view!)
    }
}

extension StudyCategoryPresenter: StudyCategoryInteractorOutputProtocol {
    func didRetrieveCategories(_ categories: [Category]) {
        view?.hideLoading()
        view?.showCategoryList(with: categories)
    }
    
    func onError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
}
