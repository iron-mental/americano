//
//  ModifyStudyProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol ModifyStudyViewProtocol {
    var presenter: ModifyStudyPresenterProtocol? { get set }
}

protocol ModifyStudyPresenterProtocol {
    var view: ModifyStudyViewProtocol? { get set }
    var wireFrame: ModifyStudyWireFrameProtocol? { get set }
    var interactor: ModifyStudyInteractorInputProtocol? { get set }
}

protocol ModifyStudyInteractorInputProtocol {
    var presenter: ModifyStudyInteractorOutputProtocol? { get set }
    var remoteDataManager: ModifyStudyRemoteDataManagerInputProtocol? { get set }
}

protocol ModifyStudyInteractorOutputProtocol {
    
}

protocol ModifyStudyRemoteDataManagerInputProtocol {
    var interactor: ModifyStudyRemoteDataManagerOutputProtocol? { get set }
}

protocol ModifyStudyRemoteDataManagerOutputProtocol {
    
}

protocol ModifyStudyWireFrameProtocol {
    
}


