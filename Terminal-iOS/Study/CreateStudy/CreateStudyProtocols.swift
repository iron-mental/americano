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
    var state: WriteStudyViewState? { get set }
    var parentView: UIViewController? { get set }
    
    //View -> PRESENTER
    func didClickButton()
    
    //PRESENTER -> VIEW
    func loading()
    func setView()
    func getBackgroundImage()
    func setBackgroundImage()
    func studyInfoInvalid(message: String)
    func studyInfoValid(studyID: Int, message: String)
}

protocol CreateStudyInteractorProtocol: class {
    var presenter: CreateStudyPresenterProtocol? { get set }
    var remoteDataManager: CreateStudyRemoteDataManagerInputProtocol? { get set }
    var studyInfo: StudyDetail? { get set }
    
    //PRESENTER -> INTERACTOR
    func studyCreateComplete(study: StudyDetailPost, studyID: Int?)
}

protocol CreateStudyPresenterProtocol: class {
    var view: CreateStudyViewProtocol? { get set }
    var interactor: CreateStudyInteractorProtocol? { get set }
    var wireFrame: CreateStudyWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func clickLocationView(currentView: UIViewController)
    func clickCompleteButton(study: StudyDetailPost, studyID: Int?)
    
    //INTERACTOR -> PRESENTER
    func showNotionValidResult(result: Bool)
    func showEvernoteValidResult(result: Bool)
    func showWebValidResult(result: Bool)
    func studyInfoInvalid(message: String)
    func studyInfoValid(studyID: Int)
}

protocol CreateStudyRemoteDataManagerInputProtocol: class {
    var interactor: CreateStudyReMoteDataManagerOutputProtocol? { get set }
    
    func postStudy(study: StudyDetailPost)
}

protocol CreateStudyReMoteDataManagerOutputProtocol: class {
    func createStudyInvalid(message: String)
    func createStudyValid(response: BaseResponse<CreateStudyResult>)
}

protocol CreateStudyWireFrameProtocol: class {
    static func createStudyViewModul(category: String, studyDetail: StudyDetail?, state: WriteStudyViewState, parentView: UIViewController?) -> UIViewController
    //추후에 스터디 모델이 들어가야겠네용?
    func goToSelectLocation(view: UIViewController)
}
