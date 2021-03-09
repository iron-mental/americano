//
//  StudyCategoryProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol StudyCategoryViewProtocol: class {
    var presenter: StudyCategoryPresenterProtocol? { get set }
    
    // PRESENT -> VIEW
    func showCategoryList(with category: [Category])
    func showError(message: String)
    func showLoading()
    func hideLoading()
    func categoryDownAnimate()
    func categoryUpAnimate()
}

protocol StudyCategoryWireFrameProtocol: class {
    static func createStudyCategory() -> UIViewController
    
    // PRESENTER -> WIREFRAME
    func presentStudyListScreen(from view: StudyCategoryViewProtocol, category: String)
    func goToSelectCategory(from view: StudyCategoryViewProtocol, category: [Category])
    func goToSearchStudy(from view: StudyCategoryViewProtocol)
}

protocol StudyCategoryPresenterProtocol: class {
    var view: StudyCategoryViewProtocol? { get set }
    var interactor: StudyCategoryInteractorInputProtocol? { get set }
    var wireFrame: StudyCategoryWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showStudyListDetail(category: String)
    func goToCreateStudy(category: [Category])
    func didClickedCreateButton()
    func goToSearchStudy()
}

protocol StudyCategoryInteractorOutputProtocol: class {
    //INTERACTOR -> PRESENTER
    func didRetrieveCategories(_ categories: [Category])
    func onError(message: String)
    func sessionTaskError(message: String)
}

protocol StudyCategoryInteractorInputProtocol: class {
    var presenter: StudyCategoryInteractorOutputProtocol? { get set }
    var localDatamanager: StudyCategoryLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: StudyCategoryRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveStudyCategory()
}

protocol StudyCategoryDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol StudyCategoryRemoteDataManagerInputProtocol: class {
    var interactor: StudyCategoryRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrievePostList()
}

protocol StudyCategoryRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onCategoriesRetrieved(result: BaseResponse<[String]>)
    func sessionTaskError(message: String)
}

protocol StudyCategoryLocalDataManagerInputProtocol: class {
     // INTERACTOR -> LOCALDATAMANAGER
    func retrieveStudyCategory() -> [Category]
}
