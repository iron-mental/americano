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

protocol CreateStudyViewProtocols: class {
    var presenter: CreateStudyPresenterProtocols? { get set }
    var study: StudyDetail? { get set }
    var studyDetailPost: StudyDetailPost? { get set }
    var state: WriteStudyViewState? { get set }
    var parentView: UIViewController? { get set }
    //VIew -> PRESENTER
    func didClickButton()
    
    //PRESENTER -> VIEW
    func loading()
    func setView()
    func getBackgroundImage()
    func setBackgroundImage()
    func showLoadingToNotionInput()
    func showLoadingToEvernoteInput()
    func showLoadingToWebInput()
    func hideLoadingToNotionInput()
    func hideLoadingToEvernoteInput()
    func hideLoadingToWebInput()
    func notionValid()
    func evernoteValid()
    func webValid()
    func notionInvalid()
    func evernoteInvalid()
    func webInvalid()
    func studyInfoInvalid(message: String)
    func studyInfoValid(message: String)
    func viewToTop()
    func viewToBottom()
}

protocol CreateStudyInteractorProtocols: class {
    var presenter: CreateStudyPresenterProtocols? { get set }
    var createStudyRemoteDataManager: CreateStudyRemoteDataManagerProtocols? { get set }
    
    //PRESENTER -> INTERACTOR
    func searchNotionID(id: String?)
    func searchEvernoteURL(url: String?)
    func searchWebURL(url: String?)
    func studyCreateComplete(study: StudyDetailPost, state: WriteStudyViewState, studyID: Int?)
    func viewDidTap(textView: UIView, viewMinY: CGFloat, viewMaxY: CGFloat)
}

protocol CreateStudyPresenterProtocols: class {
    var view: CreateStudyViewProtocols? { get set }
    var interactor: CreateStudyInteractorProtocols? { get set }
    var wireFrame: CreateStudyWireFrameProtocols? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func notionInputFinish(id: String?)
    func everNoteInputFinish(url: String?)
    func URLInputFinish(url: String?)
    func clickLocationView(currentView: UIViewController)
    func clickCompleteButton(study: StudyDetailPost, state: WriteStudyViewState, studyID: Int?)
    func viewDidTap(textView: UIView, viewMinY: CGFloat, viewMaxY: CGFloat)
    
    //INTERACTOR -> PRESENTER
    func showNotionValidResult(result: Bool)
    func showEvernoteValidResult(result: Bool)
    func showWebValidResult(result: Bool)
    func studyInfoInvalid(message: String)
    func studyInfoValid(message: String)
    func viewDidTapResult(result: Bool, topOrBottom: Bool?)
}

protocol CreateStudyRemoteDataManagerProtocols: class {
    func getNotionValid(id: String?) -> Bool
    func getEvernoteValid(url: String?) -> Bool
    func getWebValid(url: String?) -> Bool
    func postStudy(study: StudyDetailPost, completion: @escaping (_ result: Bool, _ data: String ) -> Void)
    func putStudy(study: StudyDetailPost, studyID: Int, completion: @escaping (_ result: Bool, _ data: String) -> Void)
}

protocol CreateStudyLocalDataManagerProtocols: class {
    
}

protocol CreateStudyWireFrameProtocols: class {
    static func createStudyViewModul(category: String, studyDetail: StudyDetail?, state: WriteStudyViewState, parentView: UIViewController?) -> UIViewController
    //추후에 스터디 모델이 들어가야겠네용?
    func goToSelectLocation(view: UIViewController)
}
