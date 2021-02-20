//
//  File.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol MyStudyDetailViewProtocol: class {
    var presenter: MyStudyDetailPresenterProtocol? { get set }
    var studyID: Int? { get set}
    var VCArr: [UIViewController] { get set }
    var studyTitle: String? { get set }
    var alertID: Int? { get set }
    var applyState: Bool? { get set }
    //CHILD -> PARENT
    func setting()
    
    //PRESENTER -> VIEW
    func showLeaveStudyComplete(message: String)
    func showLeaveStudyFailed(message: String)
    
    func showDeleteStudyComplete(message: String)
    func showDeleteStudyFailed(message: String)
    
}

protocol MyStudyDetailInteractorProtocol: class {
    var presenter: MyStudyDetailPresenterProtocol? { get set }
    var remoteDatamanager: MyStudyDetailRemoteDataManagerProtocol? { get set }
    var localDatamanager: MyStudyDetailLocalDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func postLeaveStudyAPI(studyID: Int)
    func callDeleteStudyAPI(studyID: Int)
    
    //DATAMANAGER -> INTERACTOR
    func leaveStudyResult(result: Bool, message: String)
    func deleteStudyResult(result: Bool, message: String)
}

protocol MyStudyDetailPresenterProtocol: class {
    var view: MyStudyDetailViewProtocol? { get set }
    var interactor: MyStudyDetailInteractorProtocol? { get set }
    var wireFrame: MyStudyDetailWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func addNoticeButtonDidTap(studyID: Int, parentView: UIViewController)
    func editStudyButtonDidTap(study: StudyDetail, parentView: UIViewController)
    func addNoticeFinished(notice: Int, studyID: Int, title: String, parentView: UIViewController)
    func showApplyUserList(studyID: Int)
    func leaveStudyButtonDidTap(studyID: Int)
    func deleteStudyButtonDidTap(studyID: Int)
    func delegateHostButtonDidTap(studyID: Int, userList: [Participate])
    
    //INTERACTOR -> PRESENTER
    func leaveStudyResult(result: Bool, message: String)
    func deleteStudyResult(result: Bool, message: String)
}

protocol MyStudyDetailRemoteDataManagerProtocol: class {
    var interactor: MyStudyDetailInteractorProtocol? { get set }
    
    //INTERACTOR -> REMOTEDATAMANAGER
    func postLeaveStudyAPI(studyID: Int)
    func callDeleteStudyAPI(studyID: Int)
}

protocol MyStudyDetailLocalDataManagerProtocol: class {
    
}

protocol MyStudyDetailWireFrameProtocol: class {
    var presenter: MyStudyDetailPresenterProtocol? { get set }
    
    static func createMyStudyDetailModule(studyID: Int, studyTitle: String, alertID: Int?) -> UIViewController

    func goToAddNotice(studyID: Int, parentView: UIViewController)
    func goToEditStudy(study: StudyDetail, parentView: UIViewController)
    func goToNoticeDetail(notice: Int, studyID: Int, title: String, parentView: UIViewController)
    func goToApplyUser(from view: MyStudyDetailViewProtocol, studyID: Int)
    func goToDelegateHost(from view: MyStudyDetailViewProtocol, studyID: Int, userList: [Participate])
}
