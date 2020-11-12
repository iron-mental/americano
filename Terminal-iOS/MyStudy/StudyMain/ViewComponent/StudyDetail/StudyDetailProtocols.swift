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
    
    // PRESENT -> VIEW
    func showStudyDetail(with studyDeatil: StudyDetail)
    func showError()
    func showLoading()
    func hideLoading()
}

protocol StudyDetailWireFrameProtocol: class {
    static func createStudyCategory() -> UIViewController
    
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
    func showStudyListDetail()
    func goToStudyDetail(studyDetail: StudyDetail)
    func didClickedCreateButton()
}

protocol StudyDetailInteractorOutputProtocol: class {
    //INTERACTOR -> PRESENTER
    func didRetrieveStudyDetail(_ studyDetail: StudyDetail)
    func onError()
}

protocol StudyDetailInteractorInputProtocol: class {
    var presenter: StudyDetailInteractorOutputProtocol? { get set }
    var localDatamanager: StudyDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: StudyDetailRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveStudyCategory()
}

protocol StudyDetailDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol StudyDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: StudyDetailRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrievePostList()
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
