//
//  MyApplyStudyInfoProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol MyApplyStudyInfoViewProtocol: class {
    var presenter: MyApplyStudyInfoPresenterProtocol? { get set }
    var applyStudy: ApplyStudy? { get set }
    
    // PRESENTER -> VIEW
    func showDeleteApply(message: String)
    func showError(message: String)
}

protocol MyApplyStudyInfoPresenterProtocol: class {
    var view: MyApplyStudyInfoViewProtocol? { get set }
    var wireFrame: MyApplyStudyInfoWireFrameProtocol? { get set }
    var interactor: MyApplyStudyInfoInteractorInputProtocol? { get set }
    
    // VIEW -> PRESENTER
    func modifyButtonDidTap(studyID: Int)
    func deleteButtonDidTap()
}

protocol MyApplyStudyInfoInteractorInputProtocol: class {
    var presenter: MyApplyStudyInfoInteractorOutputProtocol? { get set }
    var remoteDataManager: MyApplyStudyInfoRemoteDataManagerInputProtocol? { get set }
    var applyID: Int? { get set }
    var studyID: Int? { get set }
    
    // PRESENTER -> INTERACTOR
    func deleteApply()
}

protocol MyApplyStudyInfoInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func retriveDeleteApplyResult(result: Bool, message: String)
    func sessionTaskError(message: String)
}

protocol MyApplyStudyInfoRemoteDataManagerInputProtocol: class {
    var interactor: MyApplyStudyInfoRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func deleteApply(studyID: Int, applyID: Int)
}

protocol MyApplyStudyInfoRemoteDataManagerOutputProtocol: class {
    func retriveDeleteApplyResult(result: Bool, message: String)
    func sessionTaskError(message: String)
}

protocol MyApplyStudyInfoWireFrameProtocol: class {
    static func createMyApplyStudyDetailModule(applyStudy: ApplyStudy) -> UIViewController
    
    func goToMyApplyStudyModify(from view: UIViewController, studyID: Int)
}
