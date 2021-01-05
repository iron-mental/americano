//
//  File.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol MyStudyDetailViewProtocol: class {
    var presenter: MyStudyDetailPresenterProtocol? { get set }
    var studyID: Int? { get set}
    var VCArr: [UIViewController] { get set }
    
    func setting()
}

protocol MyStudyDetailInteractorProtocol: class {
    var presenter: MyStudyDetailPresenterProtocol? { get set }
    var remoteDatamanager: MyStudyDetailRemoteDataManagerProtocol? { get set }
    var localDatamanager: MyStudyDetailLocalDataManagerProtocol? { get set }
}

protocol MyStudyDetailPresenterProtocol: class {
    var view: MyStudyDetailViewProtocol? { get set }
    var interactor: MyStudyDetailInteractorProtocol? { get set }
    var wireFrame: MyStudyDetailWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func addNoticeButtonDidTap(studyID: Int, parentView: UIViewController)
    func editStudyButtonDidTap(study: StudyDetail, parentView: UIViewController)
    func addNoticeFinished(notice: Int, studyID: Int, parentView: UIViewController)
    func showApplyUserList(studyID: Int)
}

protocol MyStudyDetailRemoteDataManagerProtocol: class {
    
}

protocol MyStudyDetailLocalDataManagerProtocol: class {
    
}

protocol MyStudyDetailWireFrameProtocol: class {
    var presenter: MyStudyDetailPresenterProtocol? { get set }
    
    static func createMyStudyDetailModule(studyID: Int) -> UIViewController
    func goToAddNotice(studyID: Int, parentView: UIViewController)
    func goToEditStudy(study: StudyDetail, parentView: UIViewController)
    func goToNoticeDetail(notice: Int, studyID: Int, parentView: UIViewController)
    func goToApplyUser(from view: MyStudyDetailViewProtocol, studyID: Int)
}
