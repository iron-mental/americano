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
    
    func showCategory(category: String)
    func showLoading()
    func hideLoading()
    
}

protocol StudyMainWireFrameProtocol: class {
    static func createStudyMainModule() -> UIViewController
}

protocol StudyMainPresenterProtocol: class {
    var view: StudyMainViewProtocol? { get set }
    var interactor: StudyMainInteractorProtocol? { get set }
    var wireFrame: StudyMainWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func goToSearchStudy()
    //String은 추후에 [카테고리모델] 이런식으로 예상
    func didSearchCategory(category: String)
}

protocol StudyMainInteractorProtocol: class {
    var presenter: StudyMainPresenterProtocol? { get set }
    var localDataManager: StudyMainLocalDataManagerProtocol? { get set }
    var remoteDataManager: StudyMainRemoteDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func searchCategory()
    
}

protocol StudyMainLocalDataManagerProtocol: class {
    //String은 추후에 [카테고리모델] 이런식으로 예상
    func getCategory() -> String
}

protocol StudyMainRemoteDataManagerProtocol: class {
    func getCategory() -> String
}
