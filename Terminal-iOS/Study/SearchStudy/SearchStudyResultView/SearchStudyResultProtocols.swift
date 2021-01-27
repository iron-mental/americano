//
//  SearchStudyResultProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SearchStudyResultViewProtocol {
    var presenter: SearchStudyResultPresenterProtocol? { get set }
    var keyword: String? { get set }
    //PRESENTER -> VIEW
    func showLoading()
    func hideLoading()
    func showSearchStudyResult(result: [Study])
}

protocol SearchStudyResultInteractorProtocol {
    var presenter: SearchStudyResultPresenterProtocol? { get set }
    var remoteDataManager: SearchStudyResultRemoteDataManagerProtocol? { get set }
    var localDataManager: SearchStudyResultLocalDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func getSearchStudyResult(keyWord: String)
    
    //DATAMANAGER -> INTERACTOR
    func showSearchStudyResult(result: BaseResponse<[Study]>)
}

protocol SearchStudyResultPresenterProtocol {
    var view: SearchStudyResultViewProtocol? { get set }
    var interactor: SearchStudyResultInteractorProtocol? { get set }
    var wireFrame: SearchStudyResultWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func returnDidTap(keyWord: String)
    func didTapCell(keyValue: Int, state: Bool)
    
    //INTERACTOR -> PRESENTER
    func showSearchStudyResult(result: [Study])
}

protocol SearchStudyResultRemoteDataManagerProtocol {
    var interactor: SearchStudyResultInteractorProtocol? { get set }
    func getSearchStudyResult(keyWord: String)
}

protocol SearchStudyResultLocalDataManagerProtocol {
    
}

protocol SearchStudyResultWireFrameProtocol {
    
    static func createSearchStudyResultModule(keyword: String) -> UIViewController
    
    //PRESENTER -> WIREFRAME
    func presentStudyDetailScreen(from view: SearchStudyResultViewProtocol, keyValue: Int, state: Bool)
}

