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
    func saveLengthStudyList(with studies: [Study])
    func showLoading()
    func hideLoading()
}

protocol StudyListWireFrameProtocol: class {
    static func createStudyListModule(category: String) -> UIViewController
    
    // PRESENT -> WIREFRAME
    func presentStudyDetailScreen(from view: StudyListViewProtocol, keyValue: Int, state: Bool)
}

protocol StudyListPresenterProtocol: class {
    var view: StudyListViewProtocol? { get set }
    var interactor: StudyListInteractorInputProtocol? { get set }
    var wireFrame: StudyListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func studyList(category: String)
    func pagingStudyList()
    func pagingLengthStudyList()
    func showStudyDetail(keyValue: Int, state: Bool)
}

protocol StudyListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveStudies(studies: [Study])
    func didRetrieveLengthStudies(studies: [Study])
    func onError()
}

protocol StudyListInteractorInputProtocol: class {
    var presenter: StudyListInteractorOutputProtocol? { get set }
    var localDataManager: StudyListLocalDataManagerInputProtocol? { get set }
    var remoteDataManager: StudyListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveStudyList(category: String)
    func pagingRetrieveStudyList()
    func pagingRetrieveLengthStudyList()
}

protocol StudyListDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol StudyListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: StudyListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveStudyList(category: String)
    func retrieveLengthStudyList(category: String)
    func paginationRetrieveStudyList(keyValue: [Int], completion: @escaping (() -> Void))
    func paginationRetrieveLengthStudyList(keyValue: [Int], completion: @escaping (() -> Void))
}

protocol StudyListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onStudiesRetrieved(studies: BaseResponse<[Study]>)
    func onStudiesLengthRetrieved(studies: BaseResponse<[Study]>)
    func onError()
}

protocol StudyListLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    func retrieveStudyList() throws -> [Study]
    func saveStudylist(studyList: [Study])
//    func savePost(id: Int, title: String, imageUrl: String, thumbImageUrl: String) throws
}
