//
//  SearchStudyProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SearchStudyViewProtocol: class {
    var presenter: SearchStudyPresenterProtocol? { get set }
    
    func showHotkeyword(keyword: [HotKeyword])
    func showError(message: String)
    func showLoading()
    func hideLoading()
}

protocol SearchStudyPresenterProtocol: class {
    var view: SearchStudyViewProtocol? { get set }
    var interactor: SearchStudyInteractorInputProtocol? { get set }
    var wireFrame: SearchStudyWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func didSearchButtonClicked(keyword: String)
    func viewDidLoad()
}

protocol SearchStudyInteractorInputProtocol: class {
    var presenter: SearchStudyInteractorOutputProtocol? { get set }
    var remoteDataManager: SearchStudyRemoteDataManagerInputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func getHotKeyword()
}

protocol SearchStudyInteractorOutputProtocol: class {
    
    //INTERACTOR -> PRESENTER
    func getHotKeywordSuccess(keyword: [HotKeyword])
    func getHotKeywordFailure(message: String)
}

protocol SearchStudyRemoteDataManagerInputProtocol: class {
    var interactor: SearchStudyRemoteDataManagerOutputProtocol? { get set }
    
    //INTERACTOR -> REMOTEDATAMANAGER
    func getHotKeyword()
}

protocol SearchStudyRemoteDataManagerOutputProtocol: class {
    
    //REMOTEDATAMANAGER -> INTERACTOR
    func getHotKeywordResult(response: BaseResponse<[HotKeyword]>)
}

protocol SearchStudyWireFrameProtocol: class {
    static func createSearchStudyModule() -> UIViewController
    
    //PRESENTER -> WIREFRAME
    func goToSearchStudyRestult(from view: SearchStudyViewProtocol, keyword: String)
}
