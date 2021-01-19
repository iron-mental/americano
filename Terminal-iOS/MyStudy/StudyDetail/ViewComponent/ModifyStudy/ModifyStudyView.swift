//
//  ModifyStudyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ModifyStudyView: BaseEditableStudyDetailView {
    var presenter: ModifyStudyPresenterProtocol?
    var study: StudyDetail?
    var parentView: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func attribute() {
        super.attribute()
//        locationView
    }
    override func didLocationViewClicked() {
        presenter?.clickLocationView(currentView: self)
    }
    
}

extension ModifyStudyView: ModifyStudyViewProtocol {
    func showResult(message: String) {
        navigationController?.popViewController(animated: true)
        //이부분 presenter에서 viewDidLoad하는거 구현해야함
        (navigationController?.viewControllers.last as! StudyDetailViewProtocol).presenter?.viewDidLoad()
    }
    
    func showError() {
        print("ModifyStudyView 에서 생긴 에러 ")
    }
}
