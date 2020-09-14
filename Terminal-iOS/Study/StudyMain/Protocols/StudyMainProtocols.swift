//
//  Protocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol StudyMainViewProtocol: class {
    var presenter: StudyMainPresenterProtocol? { get set }
    
    //PRESENTER -> VIEW
    
    //func showCategory(category: [] )
    func showLoading()
    func hideLoading()
    
}

protocol StudyMainWireFrameProtocol: class {
    
}

protocol StudyMainPresenterProtocol: class {
    var view: StudyMainViewProtocol? { get set }
    var interactor: StudyMainInteractorProtocol? { get set }
    var wireFrame: StudyMainWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func goToSearchStudy()

}

protocol StudyMainInteractorProtocol: class {
    var presenter: StudyMainPresenterProtocol? { get set }
    var localDataManager: StudyMainLocalDataManagerProtocol? { get set }
    var remoteDataManager: StudyMainRemoteDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func searchCategory()
    
}

protocol StudyMainLocalDataManagerProtocol: class {
    func getCategory()
}

protocol StudyMainRemoteDataManagerProtocol: class {
    
}
