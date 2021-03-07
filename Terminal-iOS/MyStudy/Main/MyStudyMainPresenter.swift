//
//  MyStudyMainViewPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyMainPresenter: MyStudyMainPresenterProtocol {
    weak var view: MyStudyMainViewProtocol?
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
        case false:
            view?.showErrMessage(message: "서버와의 연결이 불안정합니다.")
        }
    }
    
    func didClickedCellForDetail(view: UIViewController, selectedStudy: MyStudy) {
        self.view?.showLoading()
        wireFrame?.goToStudyDetailView(view: view, studyID: selectedStudy.id, studyTitle: selectedStudy.title)
    }
    
    func showStudyDetailDirectly() {
        if let myStudyMainView = view as? UIViewController {
            wireFrame?.goToStudyDetailDirectly(view: myStudyMainView)
        }
    }
    
    func sessionTaskError(message: String) {
        view?.showErrMessage(message: message)
    }
}
