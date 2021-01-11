//
//  MyApplyStudyDetailView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class MyApplyStudyDetailView: UIViewController {
    var presenter: MyApplyStudyDetailPresenterInputProtocol?
    var studyID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard  let id = studyID else { return }
        presenter?.viewDidLoad(studyID: id )
    }
    
    func attribute() {
        self.do {
            $0.navigationItem.title = "스터디 신청 상세"
        }
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
    }
}

extension MyApplyStudyDetailView: MyApplyStudyDetailViewProtocol {
    func showMyApplyStudyDetail(message: String) {
        print(message)
        attribute()
    }
    
    func showError() {
        print("MyApplyStudyDetailView 에서 난 오류")
    }
}
