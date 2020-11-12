//
//  StudyListProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol StudyListViewProtocol: class {
    var presenter: StudyListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showStudyList(with studies: [Study])
    func showLoading()
    func hideLoading()
}

protocol StudyListWireFrameProtocol: class {
    static func createStudyListModule() -> UIViewController
    
    // PRESENT -> WIREFRAME
    func presentStudyDetailScreen(from view: StudyDetailViewProtocol)
}

protocol StudyListPresenterProtocol: class {
    var view: StudyListViewProtocol? { get set }
    var interactor: StudyListInteractorInputProtocol? { get set }
    var wireFrame: StudyListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func studyList(category: String, sort: String)
    func pagingStudyList()
    func showStudyDetail(forStudy study: Study)
}

protocol StudyListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveStudies(_ studies: [Study])
    func onError()
}

protocol StudyListInteractorInputProtocol: class {
    var presenter: StudyListInteractorOutputProtocol? { get set }
    var localDataManager: StudyListLocalDataManagerInputProtocol? { get set }
    var remoteDataManager: StudyListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveStudyList(category: String, sort: String)
    func pagingRetrieveStudyList()
}

protocol StudyListDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol StudyListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: StudyListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveStudyList(category: String, sort: String ,completionHandler: @escaping (([Study])) -> ())
    func paginationRetrieveStudyList(completionHandler: @escaping (([Study])) -> ())
    
}

protocol StudyListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onStudiesRetrieved(_ studies: [Study])
    func onError()
}

protocol StudyListLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    func retrieveStudyList() throws -> [Study]
//    func savePost(id: Int, title: String, imageUrl: String, thumbImageUrl: String) throws
}
