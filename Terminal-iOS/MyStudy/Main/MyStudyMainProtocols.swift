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
    
    //PRESENTER -> VIEW
    func showMyStudyList(myStudyList: MyStudyList)
    func showErrMessage()
    func showLoading()
}

protocol MyStudyMainWireFrameProtocol: class {   
    static func createMyStudyMainViewModul() -> UIViewController
    
    func goToStudyDetailView(view: UIViewController, selectedStudy: MyStudy)
    func goToApplyList(from view: MyStudyMainViewProtocol)
    func goToAlert(from view: MyStudyMainViewProtocol)
}

protocol MyStudyMainInteractorProtocol: class {
    var presenter: MyStudyMainPresenterProtocol? { get set }
    var remoteManager: MyStudyMainRemoteDataManagerProtocol? { get set }
    var localManager: MyStudyMainLocalDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func getMyStudyList()
}

protocol MyStudyMainPresenterProtocol: class {
    var view: MyStudyMainViewProtocol? { get set }
    var wireFrame: MyStudyMainWireFrameProtocol? { get set }
    var interactor: MyStudyMainInteractorProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func showApplyList()
    func showAlert()
    func didClickedCellForDetail(view: UIViewController, selectedStudy: MyStudy)
    
    //INTERACTOR -> PRESENTER
    func MyStudyListResult(result: Bool, itemList: MyStudyList?)
    
}

protocol MyStudyMainRemoteDataManagerProtocol: class {
    var interactor: MyStudyMainInteractorProtocol? { get set }
    //INTERACTOR -> RemoteDataManager
    func getMyStudyList(completion: @escaping (_: BaseResponse<MyStudyList>) -> Void)
    //func getStudyDetail
}

protocol MyStudyMainLocalDataManagerProtocol: class {

}
