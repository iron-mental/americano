//
//  StudyDetailViewControllerProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/16.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

protocol StudyDetailViewControllerViewProtocol {
    var presenter: StudyDetailViewControllerPresenterProtocol? { get set }
    var studyInfo: MyStudy? { get set }
    
    //PRESENTER -> VIEW
    func showStudyDetailResult(studyInfo: StudyDetail)
}

protocol StudyDetailViewControllerInteractorProtocol {
    var presenter: StudyDetailViewControllerPresenterProtocol? { get set }
    var remoteDataManager: StudyDetailViewControllerRemoteDataManagerProtocol? { get set }
    var localDataManager: StudyDetailViewControllerLocalDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func getStudyDetailInfo(study: MyStudy)
    
}

protocol StudyDetailViewControllerPresenterProtocol {
    var view: StudyDetailViewControllerViewProtocol? { get set }
    var interactor: StudyDetailViewControllerInteractorProtocol? { get set }
    var wireFrame: StudyDetailViewControllerWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad(study: MyStudy)
    
    //INTERACTOR -> PRESENTER
    func studyDetailInfoResult(result: Bool, studyInfo: StudyDetail)
}

protocol StudyDetailViewControllerRemoteDataManagerProtocol {
    //INTERACTOR -> REMOTEDATAMANAGER
    func callStudyDetailInfoAPI(id: Int, completion: @escaping (_: Bool, _: StudyDetail) -> ())
}

protocol StudyDetailViewControllerLocalDataManagerProtocol {
    
}

protocol StudyDetailViewControllerWireFrameProtocol {
    var presenter: StudyDetailViewControllerPresenterProtocol? { get set }
}
