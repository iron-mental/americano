//
//  CreateStudyProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol CreateStudyViewProtocols: class {
    var presenter: CreateStudyPresenterProtocols? { get set }
    
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
}

protocol CreateStudyInteractorProtocols: class {
    var presenter: CreateStudyPresenterProtocols? { get set }
    var createStudyRemoteDataManager: CreateStudyRemoteDataManagerProtocols? { get set }
    
    //PRESENTER -> INTERACTOR
    func searchNotionID(id: String?)
    func searchEvernoteURL(url: String?)
    func searchWebURL(url: String?)
    func studyCreateComplete(study: StudyDetailPost)
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
    func clickCompleteButton(study: StudyDetailPost)
    
    //INTERACTOR -> PRESENTER
    func showNotionValidResult(result: Bool)
    func showEvernoteValidResult(result: Bool)
    func showWebValidResult(result: Bool)
    func studyInfoInvalid(message: String)
    func studyInfoValid(message: String)
}

protocol CreateStudyRemoteDataManagerProtocols: class {
    func getNotionValid(id: String?) -> Bool
    func getEvernoteValid(url: String?) -> Bool
    func getWebValid(url: String?) -> Bool
    func postStudy(study: StudyDetailPost, completion: @escaping (_: Bool, _: String ) -> Void)

}

protocol CreateStudyLocalDataManagerProtocols: class {
    
}

protocol CreateStudyWireFrameProtocols: class {
    static func createStudyViewModul(category: Category) -> UIViewController
    //추후에 스터디 모델이 들어가야겠네용?
    func goToSelectLocation(view: UIViewController)
}
