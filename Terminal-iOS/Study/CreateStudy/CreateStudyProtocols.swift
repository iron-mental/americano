//
//  CreateStudyProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

enum WriteStudyViewState {
    case create
    case edit
}

protocol CreateStudyViewProtocol: class {
    var presenter: CreateStudyPresenterProtocol? { get set }
    var study: StudyDetail? { get set }
    var studyDetailPost: StudyDetailPost? { get set }
    var parentView: UIViewController? { get set }
    
    //PRESENTER -> VIEW
    func showLoading()
    func hideLoading()
    func setView()
    func getBackgroundImage()
    func setBackgroundImage()
    func studyInfoInvalid(label: String?, message: String)
    func studyInfoValid(studyID: Int, message: String)
}

protocol CreateStudyInteractorInputProtocol: class {
    var presenter: CreateStudyInteractorOutputProtocol? { get set }
    var remoteDataManager: CreateStudyRemoteDataManagerInputProtocol? { get set }
    var studyInfo: StudyDetail? { get set }
    
    //PRESENTER -> INTERACTOR
    func studyCreateComplete(study: StudyDetailPost, studyID: Int?)
}

protocol CreateStudyInteractorOutputProtocol: class {
    
    //INTERACTOR -> PRESENTER
    func studyInfoInvalid(label: String?, message: String)
    func studyInfoValid(studyID: Int, message: String)
}

protocol CreateStudyPresenterProtocol: class {
    var view: CreateStudyViewProtocol? { get set }
    var interactor: CreateStudyInteractorInputProtocol? { get set }
    var wireFrame: CreateStudyWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func clickLocationView()
    func clickCompleteButton(study: StudyDetailPost, studyID: Int?)
}

protocol CreateStudyRemoteDataManagerInputProtocol: class {
    var interactor: CreateStudyReMoteDataManagerOutputProtocol? { get set }
    
    func postStudy(study: StudyDetailPost)
}

protocol CreateStudyReMoteDataManagerOutputProtocol: class {
    func createStudyValid(response: BaseResponse<CreateStudyResult>)
}

protocol CreateStudyWireFrameProtocol: class {
    static func createStudyViewModule(category: String,
                                      studyDetail: StudyDetail?,
                                      parentView: UIViewController?) -> UIViewController
    //추후에 스터디 모델이 들어가야겠네용?
    func goToSelectLocation(from view: CreateStudyViewProtocol)
}
