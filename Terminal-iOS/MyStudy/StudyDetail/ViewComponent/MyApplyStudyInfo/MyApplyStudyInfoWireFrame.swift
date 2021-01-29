//
//  MyApplyStudyDetailWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class MyApplyStudyInfoWireFrame: MyApplyStudyInfoWireFrameProtocol {
    
    static func createMyApplyStudyDetailModule(applyStudy: ApplyStudy) -> UIViewController {
        let view  = MyApplyStudyInfoView()
        let presenter = MyApplyStudyInfoPresenter()
        
        view.applyStudy = applyStudy
        view.presenter = presenter
        
        presenter.view = view
        return view
    }
    
    func goToMyApplyStudyModify(from view: UIViewController, studyID: Int) {
        let myApplyStudyModifyView = MyApplyStudyModifyWireFrame.createMyApplyStudyModifyModule(studyID: studyID)
        view.navigationController?.pushViewController(myApplyStudyModifyView, animated: true)
    }
}
