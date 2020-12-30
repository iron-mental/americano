//
//  SearchStudyProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SearchStudyViewProtocol {
    var presenter: SearchStudyPresenterProtocol? { get set }
}

protocol SearchStudyInteractorProtocol {
    var presenter: SearchStudyPresenterProtocol? { get set }
    var remoteDataManager: SearchStudyRemoteDataManagerProtocol? { get set }
    var localDataManager: SearchStudyLocalDataManagerProtocol? { get set }
}

protocol SearchStudyPresenterProtocol {
    var view: SearchStudyViewProtocol? { get set }
    var interactor: SearchStudyInteractorProtocol? { get set }
    var wireFrame: SearchStudyWireFrameProtocol? { get set }
}

protocol SearchStudyRemoteDataManagerProtocol {
    
}

protocol SearchStudyLocalDataManagerProtocol {
    
}

protocol SearchStudyWireFrameProtocol {
    var presenter: SearchStudyPresenterProtocol? { get set }
    
    static func createSearchStudyModule() -> UIViewController
}
