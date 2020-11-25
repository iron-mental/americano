//
//  NoticeProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol NoticeViewProtocol {
    var presenter: NoticePresenterProtocol? { get set }
}

protocol NoticeInteractorProtocol {
    var presenter: NoticePresenterProtocol? { get set }
    var remoteDataManager: NoticeRemoteDataManagerProtocol? { get set }
    var localDataManager: NoticeLocalDataManagerProtocol? { get set }
}

protocol NoticePresenterProtocol {
    var view: NoticeViewProtocol? { get set }
    var wireFrame: NoticeWireFrameProtocol? { get set }
    var interactor: NoticeInteractorProtocol? { get set }
}

protocol NoticeRemoteDataManagerProtocol {
    
}

protocol NoticeLocalDataManagerProtocol {
    
}

protocol NoticeWireFrameProtocol {
    var presenter: NoticePresenterProtocol? { get set }
    
    static func createNoticeModule(studyID: Int) -> UIViewController
}
