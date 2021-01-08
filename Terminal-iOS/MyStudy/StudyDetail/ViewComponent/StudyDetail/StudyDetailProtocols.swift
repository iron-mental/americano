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
    var parentView: MyStudyDetailViewProtocol? { get set }
    // PRESENT -> VIEW
    func showStudyDetail(with studyDetail: StudyDetail)
    func showError()
    func showLoading()
    func hideLoading()
    func studyJoinResult(message: String)
}

protocol StudyDetailWireFrameProtocol: class {
    static func createStudyDetail(parent: MyStudyDetailViewProtocol?, studyID: Int, state: StudyDetailViewState) -> UIViewController
    
    // PRESENTER -> WIREFRAME
    func presentStudyListScreen(from view: StudyDetailViewProtocol)
    func goToSelectCategory(from view: StudyDetailViewProtocol, category: [Category])
    
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
    
    //INTERACTOR -> PRESENTER
    
}

protocol StudyDetailInteractorInputProtocol: class {
    var presenter: StudyDetailInteractorOutputProtocol? { get set }
    var localDatamanager: StudyDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: StudyDetailRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveStudyDetail(studyID: String)
    func postStudyJoin(studyID: Int, message: String)
}

protocol StudyDetailInteractorOutputProtocol: class {
    //INTERACTOR -> PRESENTER
    func didRetrieveStudyDetail(_ studyDetail: StudyDetail)
    func studyJoinResult(result: Bool, message: String)
    func onError()
}

protocol StudyDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: StudyDetailRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func getStudyDetail(studyID: String, completionHandler: @escaping (StudyDetail) -> Void)
    func postStudyJoin(studyID: Int, message: String, completion: @escaping (_ result: Bool, _ data: String) -> Void)
}

protocol StudyDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
       func onStudyDetailRetrieved(_ studyDetail: StudyDetail)
       func onError()
}

protocol StudyDetailLocalDataManagerInputProtocol: class {
     // INTERACTOR -> LOCALDATAMANAGER
    func retrieveStudyDetail() -> StudyDetail
}
