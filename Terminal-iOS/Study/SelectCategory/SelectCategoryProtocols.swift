//
//  SelectCategoryProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SelectCategoryViewProtocol: class {
    var presenter: SelectCategoryPresenterProtocol? { get set }
    
    //PRESENTER -> VIEW
    func showCategory()
    
    //VIEW -> PRESENTER
    func backTapped()
}

protocol SelectCategoryPresenterProtocol: class {
    var view: SelectCategoryViewProtocol? { get set }
    var wireFrame: SelectCategoryWireFrameProtocol? { get set }

    //VIEW -> PRESENTER
    func viewDidLoad()
    func go(selected: Category)
    func back()
}

protocol SelectCategoryWireFrameProtocol: class {
    static func createSelectCategoryViewModule(category: [Category]) -> UIViewController
    
    func goToCreateStudy(view: UIViewController, category: Category)
    func backToStudyMain(view: UIViewController)
}
