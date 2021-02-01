//
//  SearchStudyResultProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SearchStudyResultViewProtocol: class {
    var presenter: SearchStudyResultPresenterProtocol? { get set }
    var keyword: String? { get set }
    //PRESENTER -> VIEW
    func showLoading()
    func hideLoading()
    func showSearchStudyResult(result: [Study])
}

protocol SearchStudyResultPresenterProtocol: class {
    var view: SearchStudyResultViewProtocol? { get set }
    var interactor: SearchStudyResultInteractorInputProtocol? { get set }
    var wireFrame: SearchStudyResultWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func returnDidTap(keyWord: String)
    func didTapCell(keyValue: Int, state: Bool)
}

protocol SearchStudyResultInteractorInputProtocol: class {
    var presenter: SearchStudyResultInteractorOutputProtocol? { get set }
    var remoteDataManager: SearchStudyResultRemoteDataManagerInputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func getSearchStudyResult(keyWord: String)
}

protocol SearchStudyResultInteractorOutputProtocol: class {
    //INTERACTOR -> PRESENTER
    func showSearchStudyResult(result: [Study])
}

protocol SearchStudyResultRemoteDataManagerInputProtocol: class {
    var interactor: SearchStudyResultRemoteDataManagerOutputProtocol? { get set }
    //INTERACTOR -> REMOTEDATAMANAGER
    func getSearchStudyResult(keyWord: String)
}

protocol SearchStudyResultRemoteDataManagerOutputProtocol: class {
    //DATAMANAGER -> INTERACTOR
    func showSearchStudyResult(result: BaseResponse<[Study]>)
}

protocol SearchStudyResultWireFrameProtocol: class {
    
    static func createSearchStudyResultModule(keyword: String) -> UIViewController
    
    //PRESENTER -> WIREFRAME
    func presentStudyDetailScreen(from view: SearchStudyResultViewProtocol, keyValue: Int, state: Bool)
}
