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
    
    //PRESENTER -> VIEW
    func showDeleteApply(message: String)
    func showError()
}

protocol MyApplyStudyInfoPresenterInputProtocol {
    var view: MyApplyStudyInfoViewProtocol? { get set }
    var wireFrame: MyApplyStudyInfoWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func modifyButtonDidTap(studyID: Int)
    func deleteButtonDidTap()
}

protocol MyApplyStudyInfoInteractorInputProtocol {
    var presenter: MyApplyStudyInfoInteractorOutputProtocol? { get set }
    var remoteDataManager: MyApplyStudyInfoRemoteDataManagerInputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func deleteApply()
}

protocol MyApplyStudyInfoInteractorOutputProtocol {
    //INTERACTOR -> PRESENTER
    func retriveDeleteApplyResult(result: Bool, message: String)
}

protocol MyApplyStudyInfoRemoteDataManagerInputProtocol {
    var interactor: MyApplyStudyInfoRemoteDataManagerOutputProtocol? { get set }
    
    //INTERACTOR -> REMOTEDATAMANAGER
    func deleteApply(studyID: Int, applyID: Int)
}

protocol MyApplyStudyInfoRemoteDataManagerOutputProtocol {
    func retriveDeleteApplyResult(result: Bool, message: String)
}

protocol MyApplyStudyInfoWireFrameProtocol {
    static func createMyApplyStudyDetailModule(applyStudy: ApplyStudy) -> UIViewController
    
    func goToMyApplyStudyModify(from view: UIViewController, studyID: Int)
}
