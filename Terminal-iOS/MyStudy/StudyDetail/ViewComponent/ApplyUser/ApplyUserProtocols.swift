//
//  ApplyUserProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol ApplyUserViewProtocol: class {
    var presenter: ApplyUserPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showStudyList(studies: [ApplyStudy]?)
    func showLoading()
    func hideLoading()
}

protocol ApplyUserWireFrameProtocol: class {
    static func createStudyListModule() -> UIViewController
    
    // PRESENT -> WIREFRAME
    func presentUserInfoDetailScreen(from view: ApplyUserViewProtocol)
}

protocol ApplyUserPresenterProtocol: class {
    var view: ApplyUserViewProtocol? { get set }
    var interactor: ApplyUserInteractorInputProtocol? { get set }
    var wireFrame: ApplyUserWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showStudyDetail(keyValue: Int, state: Bool)
}

protocol ApplyUserInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveStudies(studies: [ApplyStudy]?)
    func onError()
}

protocol ApplyUserInteractorInputProtocol: class {
    var presenter: MyApplyListInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func getApplyList()
}
