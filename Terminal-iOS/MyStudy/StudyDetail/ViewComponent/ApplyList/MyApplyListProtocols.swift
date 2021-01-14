//
//  MyApplyListProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol MyApplyListViewProtocol: class {
    var presenter: MyApplyListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showStudyList(studies: [ApplyStudy]?)
    func showLoading()
    func hideLoading()
}

protocol MyApplyListWireFrameProtocol: class {
    static func createStudyListModule() -> UIViewController
    
    // PRESENT -> WIREFRAME
    func presentStudyDetailScreen(from view: MyApplyListViewProtocol, studyID: Int)
}

protocol MyApplyListPresenterProtocol: class {
    var view: MyApplyListViewProtocol? { get set }
    var interactor: MyApplyListInteractorInputProtocol? { get set }
    var wireFrame: MyApplyListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showStudyDetail(keyValue: Int)
}

protocol MyApplyListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveStudies(studies: [ApplyStudy]?)
//    func userIDResult(studyID: Int, userID: Int)
    func onError()
}

protocol MyApplyListInteractorInputProtocol: class {
    var presenter: MyApplyListInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func getApplyList()
//    func getUserID(studyID: Int)
}
