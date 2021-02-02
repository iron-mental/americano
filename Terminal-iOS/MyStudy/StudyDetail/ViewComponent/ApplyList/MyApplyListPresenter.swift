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
        LoadingRainbowCat.show()
        interactor?.getApplyList()
    }
    
    func showStudyDetail(applyStudy: ApplyStudy) {
        wireFrame?.presentStudyDetailScreen(from: view!, applyStudy: applyStudy)
    }
}

extension MyApplyListPresenter: MyApplyListInteractorOutputProtocol {
    func didRetrieveStudies(studies: [ApplyStudy]?) {
        LoadingRainbowCat.hide {
            self.view?.showStudyList(studies: studies)
        }
    }
    
    func onError() {
        LoadingRainbowCat.hide {
            print("MyApplylistPresenter 에서 생긴 에러")
        }
    }
}
