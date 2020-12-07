//
//  File.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol MyStudyDetailViewProtocol {
    var presenter: MyStudyDetailPresenterProtocol? { get set }
    var studyID: Int? { get set}
    var VCArr: [UIViewController] { get set }
    
}

protocol MyStudyDetailInteractorProtocol {
    var presenter: MyStudyDetailPresenterProtocol? { get set }
    var remoteDatamanager: MyStudyDetailRemoteDataManagerProtocol? { get set }
    var localDatamanager: MyStudyDetailLocalDataManagerProtocol? { get set }
}

protocol MyStudyDetailPresenterProtocol {
    var view : MyStudyDetailViewProtocol? { get set }
    var interactor: MyStudyDetailInteractorProtocol? { get set }
    var wireFrame: MyStudyDetailWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func addNoticeButtonDidTap(studyID: Int, parentView: UIViewController)
    func editStudyButtonDidTap(study: StudyDetail, parentView: UIViewController)
    func addNoticeFinished(notice: Int, studyID: Int, parentView: UIViewController)
}

protocol MyStudyDetailRemoteDataManagerProtocol {
    
}

protocol MyStudyDetailLocalDataManagerProtocol {
    
}

protocol MyStudyDetailWireFrameProtocol {
    var presenter: MyStudyDetailPresenterProtocol? { get set }
    
    static func createMyStudyDetailModule(studyID: Int) -> UIViewController
    func goToAddNotice(studyID: Int, parentView: UIViewController)
    func goToEditStudy(study: StudyDetail, parentView: UIViewController)
    func goToNoticeDetail(notice: Int, studyID: Int, parentView: UIViewController)
}
