//
//  SearchStudyResultProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SearchStudyResultViewProtocol {
    var presenter: SearchStudyResultPresenterProtocol? { get set }
}

protocol SearchStudyResultInteractorProtocol {
    var presenter: SearchStudyResultPresenterProtocol? { get set }
    var remoteDataManager: SearchStudyResultRemoteDataManagerProtocol? { get set }
    var localDataManager: SearchStudyResultLocalDataManagerProtocol? { get set }
}

protocol SearchStudyResultPresenterProtocol {
    var view: SearchStudyResultViewProtocol? { get set }
    var interactor: SearchStudyResultInteractorProtocol? { get set }
    var wireFrame: SearchStudyResultWireFrameProtocol? { get set }
}

protocol SearchStudyResultRemoteDataManagerProtocol {
    
}

protocol SearchStudyResultLocalDataManagerProtocol {
    
}

protocol SearchStudyResultWireFrameProtocol {
    var presenter: SearchStudyResultPresenterProtocol? { get set }
    
    static func createSearchStudyResultModule() -> UIViewController
}

