//
//  MyApplyStudyInfoProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol MyApplyStudyInfoViewProtocol {
    var presenter: MyApplyStudyInfoPresenterInputProtocol? { get set }
    var applyStudy: ApplyStudy? { get set }
}

protocol MyApplyStudyInfoPresenterInputProtocol {
    var view: MyApplyStudyInfoViewProtocol? { get set }
    var wireFrame: MyApplyStudyInfoWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func modifyButtonDidTap(studyID: Int)
}

protocol MyApplyStudyInfoWireFrameProtocol {
    static func createMyApplyStudyDetailModule(applyStudy: ApplyStudy) -> UIViewController
    
    func goToMyApplyStudyModify(from view: UIViewController, studyID: Int)
}
