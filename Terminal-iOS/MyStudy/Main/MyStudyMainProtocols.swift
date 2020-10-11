//
//  MyStudyMainProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol MyStudyMainViewProtocol: class {
    var presenter: MyStudyMainPresenterProtocol? { get set }
}

protocol MyStudyMainInteractorProtocol: class {
    var presenter: MyStudyMainPresenterProtocol? { get set }
}

protocol MyStudyMainPresenterProtocol: class {
    var view: MyStudyMainViewProtocol? { get set }
    var wireFrame: MyStudyMainWireFrameProtocol { get set }
    var interactor: MyStudyMainInteractorProtocol { get set }
}

protocol MyStudyMainRemoteDataManagerProtocol: class {

}

protocol MyStudyMainLocalDataManagerProtocol: class {

}

protocol MyStudyMainWireFrameProtocol: class {
    static func createMyStudyMainViewModul() -> UIViewController
    
    func goToAalrmView(view: UIViewController)
}


