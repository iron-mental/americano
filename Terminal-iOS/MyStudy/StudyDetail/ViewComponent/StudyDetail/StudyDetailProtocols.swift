//
//  StudyDetailProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol StudyDetailViewProtocol: class {
    var presenter: StudyDetailPresenterProtocol? { get set }
    var state: StudyDetailViewState { get set }
    var studyID: Int? { get set }
    var studyInfo: StudyDetail? { get set }
    var parentView: MyStudyDetailViewProtocol? { get set }
    var studyTitle: String? { get set }
    
    // PRESENTER -> VIEW
    func showStudyDetail(with studyDetail: StudyDetail)
    func showError(message: String)
    func showLoading()
    func hideLoading()
    func studyJoinResult(message: String)
    func showReportResult(message: String)
}

protocol StudyDetailWireFrameProtocol: class {
    static func createStudyDetail(parent: MyStudyDetailViewProtocol?, studyID: Int, state: StudyDetailViewState, studyTitle: String) -> UIViewController
    
    // PRESENTER -> WIREFRAME
    func presentStudyListScreen(from view: StudyDetailViewProtocol)
    func goToSelectCategory(from view: StudyDetailViewProtocol, category: [Category])
    func goToApplyStudyDetail(from view: StudyDetailViewProtocol, studyID: Int)
    func goToParticipantProfile(from view: StudyDetailViewProtocol, userID: Int)
    func goToSNSWebView(from view: StudyDetailViewProtocol, url: String)
}

protocol StudyDetailPresenterProtocol: class {
    var view: StudyDetailViewProtocol? { get set }
    var interactor: StudyDetailInteractorInputProtocol? { get set }
    var wireFrame: StudyDetailWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showStudyListDetail(studyID: String)
    func goToStudyDetail(studyDetail: StudyDetail)
    func didClickedCreateButton()
    func joinButtonDidTap(studyID: Int, message: String)
    func modifyStudyMessageButtonDidTap(studyID: Int)
    func memberDidTap(userID: Int)
    func snsButtonDidTap(url: String)
    func reportConfirmButtonDidTap(studyID: Int, reportMessage: String)
    // INTERACTOR -> PRESENTER
    
}

protocol StudyDetailInteractorInputProtocol: class {
    var presenter: StudyDetailInteractorOutputProtocol? { get set }
    var localDatamanager: StudyDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: StudyDetailRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveStudyDetail(studyID: String)
    func postStudyJoin(studyID: Int, message: String)
    func postReportStudy(studyID: Int, reportMessage: String)
}

protocol StudyDetailInteractorOutputProtocol: class {

    // INTERACTOR -> PRESENTER
    func didRetrieveStudyDetail(_ studyDetail: StudyDetail)
    func studyJoinResult(result: Bool, message: String)
    func onError(message: String)
    func postReportStudyResult(result: Bool, message: String)
    func sessionTaskError(message: String)
}

protocol StudyDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: StudyDetailRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func getStudyDetail(studyID: String)
    func postStudyJoin(studyID: Int, message: String)
    func postReportStudy(studyID: Int, reportMessage: String)
}

protocol StudyDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onStudyDetailRetrieved(result: BaseResponse<StudyDetailInfo>)
    func postStudyJoinResult(result: BaseResponse<String>)
    func postReportStudyResult(result: BaseResponse<String>)
    func sessionTaskError(message: String)
}

protocol StudyDetailLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    func retrieveStudyDetail() -> StudyDetail
}
