//
//  SearchStudyProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SearchStudyViewProtocol: class {
    var presenter: SearchStudyPresenterProtocol? { get set }
}

protocol SearchStudyInteractorProtocol: class {
    var presenter: SearchStudyPresenterProtocol? { get set }
    var remoteDataManager: SearchStudyRemoteDataManagerProtocol? { get set }
    var localDataManager: SearchStudyLocalDataManagerProtocol? { get set }
}

protocol SearchStudyPresenterProtocol: class {
    var view: SearchStudyViewProtocol? { get set }
    var interactor: SearchStudyInteractorProtocol? { get set }
    var wireFrame: SearchStudyWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func didSearchButtonClicked(keyword: String)
}

protocol SearchStudyRemoteDataManagerProtocol: class {
    
}

protocol SearchStudyLocalDataManagerProtocol: class {
    
}

protocol SearchStudyWireFrameProtocol: class {
    static func createSearchStudyModule() -> UIViewController
    
    //PRESENTER -> WIREFRAME
    func goToSearchStudyRestult(from view: SearchStudyViewProtocol, keyword: String)
}
