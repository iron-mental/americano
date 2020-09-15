//
//  SelectCategoryPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectCategoryPresenter: SelectCategoryPresenterProtocols {
    var view: SelectCategoryViewProtocols?
    var wireFrame: SelectCategoryWireFrameProtocols?
    
    func viewDidLoad() {
        view?.showCategory()
    }
    func go(selected: String) {
        wireFrame?.goToCreateStudy(view: view as! UIViewController)
    }
    func back() {
        view?.backTapped()
        wireFrame?.backToStudyMain(view: view as! UIViewController)
    }
}
