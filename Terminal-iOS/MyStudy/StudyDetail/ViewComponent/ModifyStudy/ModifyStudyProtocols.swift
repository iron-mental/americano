//
//  ModifyStudyProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol ModifyStudyViewProtocol: class {
    var presenter: ModifyStudyPresenterProtocol? { get set }
    var study: StudyDetail? { get set }
    //PRESENTER -> VIEW
    func showResult(message: String)
    func showError(message: String)
}

protocol ModifyStudyPresenterProtocol: class {
    var view: ModifyStudyViewProtocol? { get set }
    var wireFrame: ModifyStudyWireFrameProtocol? { get set }
    var interactor: ModifyStudyInteractorInputProtocol? { get set }
    
    //VIEW -> PRESENTER
    func completButtonDidTap(studyID: Int, study: StudyDetailPost)
    func clickLocationView(currentView: UIViewController)
}

protocol ModifyStudyInteractorInputProtocol: class {
    var presenter: ModifyStudyInteractorOutputProtocol? { get set }
    var remoteDataManager: ModifyStudyRemoteDataManagerInputProtocol? { get set }
    var currentStudy: StudyDetail? { get set }
    
    //PRESENTER -> INTERACTOR
    func putStudyInfo(studyID: Int, study: StudyDetailPost)
}

protocol ModifyStudyInteractorOutputProtocol: class {
    //INTERACTOR -> PRESENTER
    func putStudyInfoResult(result: Bool, message: String)
}

protocol ModifyStudyRemoteDataManagerInputProtocol: class {
    var interactor: ModifyStudyRemoteDataManagerOutputProtocol? { get set }
    
    //INTERACTOR -> REMOTEDATAMANAGER
    func putStudyInfo(studyID: Int, study: StudyDetailPost)
}

protocol ModifyStudyRemoteDataManagerOutputProtocol: class {
    //REMOTEDATAMANAGER -> INTERACTOR
    func putStudyInfoResult(result: Bool, message: String)
}

protocol ModifyStudyWireFrameProtocol: class {
    static func createModifyStudyModule(study: StudyDetail, parentView: UIViewController) -> UIViewController
    
    //PRESENTER -> WIREFRAME
    func goToSelectLocation(view: UIViewController)
}
