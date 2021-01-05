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
    
    //CHILD -> PARENT
    func setting()
    
    //PRESENTER -> VIEW
    func showLeaveStudyComplete()
    func showLeaveStudyFailed()
    
    func showDeleteStudyComplete()
    func showDeleteStudyFailed()
    
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
    func addNoticeFinished(notice: Int, studyID: Int, parentView: UIViewController)
    func showApplyUserList(studyID: Int)
    func leaveStudyButtonDidTap(studyID: Int)
    func deleteStudyButtonDidTap(studyID: Int)
    
    //INTERACTOR -> PRESENTER
    func leaveStudyResult(result: Bool, message: String)
    func delegateHostResult(result: Bool, message: String)
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
    
    static func createMyStudyDetailModule(studyID: Int) -> UIViewController
    func goToAddNotice(studyID: Int, parentView: UIViewController)
    func goToEditStudy(study: StudyDetail, parentView: UIViewController)
    func goToNoticeDetail(notice: Int, studyID: Int, parentView: UIViewController)
    func goToApplyUser(from view: MyStudyDetailViewProtocol, studyID: Int)
}
