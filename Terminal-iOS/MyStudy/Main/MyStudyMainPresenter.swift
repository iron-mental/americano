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
        view?.showLoading()
        interactor?.getMyStudyList()
    }
    
    func showApplyList() {
        wireFrame?.goToApplyList(from: view!)
    }
    
    func showAlert() {
        wireFrame?.goToAlert(from: view!)
    }
    
    func MyStudyListResult(result: Bool, itemList: MyStudyList?) {
        switch result {
        case true:
            view?.showMyStudyList(myStudyList: itemList!)
            break
        case false:
            view?.showErrMessage()
        }
    }
    
    func didClickedCellForDetail(view: UIViewController, selectedStudy: MyStudy) {
        LoadingRainbowCat.show()
        wireFrame?.goToStudyDetailView(view: view, selectedStudy: selectedStudy)
    }
}
