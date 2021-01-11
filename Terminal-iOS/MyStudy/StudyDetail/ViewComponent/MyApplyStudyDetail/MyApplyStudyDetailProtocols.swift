//
//  MyApplyStudyDetailProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit


protocol MyApplyStudyDetailViewProtocol {
    var presenter: MyApplyStudyDetailPresenterInputProtocol? { get set }
}

protocol MyApplyStudyDetailPresenterInputProtocol {
    var view: MyApplyStudyDetailViewProtocol? { get set }
    var interactor: MyApplyStudyDetailInteractorInputProtocol? { get set }
    var wireFrame: MyApplyStudyDetailWireFrameProtocol? { get set }
    
}

protocol MyApplyStudyDetailInteractorInputProtocol {
    var presenter: MyApplyStudyDetailInteractorOutputProtocol? { get set }
    var remoteDataManager: MyApplyStudyDetailRemoteDataManagerInputProtocol? { get set }
}

protocol MyApplyStudyDetailInteractorOutputProtocol {
    
}

protocol MyApplyStudyDetailRemoteDataManagerInputProtocol {
    var interactor: MyApplyStudyDetailRemoteDataManagerOutputProtocol? { get set }
}

protocol MyApplyStudyDetailRemoteDataManagerOutputProtocol {
    
}

protocol MyApplyStudyDetailWireFrameProtocol {
    static func createMyApplyStudyDetailModule(studyID: Int) -> UIViewController
}
