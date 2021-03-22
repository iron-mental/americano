//
//  SelectCategoryPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectCategoryPresenter: SelectCategoryPresenterProtocol {
    weak var view: SelectCategoryViewProtocol?
    var wireFrame: SelectCategoryWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showCategory()
    }
    func go(selected: Category) {
        view?.showLoading()
        wireFrame?.goToCreateStudy(view: view as! UIViewController, category: selected)
    }
    func back() {
        view?.backTapped()
        wireFrame?.backToStudyMain(view: view as! UIViewController)
    }
}
