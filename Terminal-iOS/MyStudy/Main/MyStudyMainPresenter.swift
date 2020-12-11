//
//  MyStudyMainViewPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyMainPresenter: MyStudyMainPresenterProtocol {
    var view: MyStudyMainViewProtocol?
    var wireFrame: MyStudyMainWireFrameProtocol?
    var interactor: MyStudyMainInteractorProtocol?
    
    func viewDidLoad() {
        interactor?.getMyStudyList()
    }
    
    func showApplyList() {
        wireFrame?.goToApplyList(from: view!)
    }
    
    func MyStudyListResult(result: Bool, itemList: [MyStudy]?) {
        switch result {
        case true:
            view?.showMyStudyList(myStudyList: itemList!)
            break
        case false:
            view?.showErrMessage()
            break
        }
    }
    
    func didClickedCellForDetail(view: UIViewController, selectedStudy: MyStudy) {
        wireFrame?.goToStudyDetailView(view: view, selectedStudy: selectedStudy)
    }
}
