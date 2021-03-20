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
    func showError(message: String)
}

protocol StudyListWireFrameProtocol: class {
    static func createStudyListModule(category: String) -> UIViewController
    
    // PRESENT -> WIREFRAME
    func presentStudyDetailScreen(from view: StudyListViewProtocol, keyValue: Int, state: Bool, studyTitle: String)
}

protocol StudyListPresenterProtocol: class {
    var view: StudyListViewProtocol? { get set }
    var interactor: StudyListInteractorInputProtocol? { get set }
    var wireFrame: StudyListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func studyList(category: String)
    func pagingStudyList()
    func pagingLengthStudyList()
    func showStudyDetail(keyValue: Int, state: Bool, studyTitle: String)
}

protocol StudyListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveLatestStudies(studies: [Study])
    func didRetrieveLengthStudies(studies: [Study])
    func sessionTaskError(message: String)
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

protocol StudyListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: StudyListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveLatestStudyList(category: String)
    func retrieveLengthStudyList(category: String)
    func paginationRetrieveLatestStudyList(keyValue: [Int], completion: @escaping (() -> Void))
    func paginationRetrieveLengthStudyList(keyValue: [Int], completion: @escaping (() -> Void))
}

protocol StudyListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onStudiesLatestRetrieved(result: BaseResponse<[Study]>)
    func onStudiesLengthRetrieved(result: BaseResponse<[Study]>)
    func onStudiesForKeyLatestRetrieved(result: BaseResponse<[Study]>)
    func onStudiesForKeyLengthRetrieved(result: BaseResponse<[Study]>)
    func sessionTaskError(message: String)
}

protocol StudyListLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    func retrieveStudyList() throws -> [Study]
    func saveStudylist(studyList: [Study])
}
