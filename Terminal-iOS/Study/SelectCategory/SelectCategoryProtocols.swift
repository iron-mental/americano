//
//  SelectCategoryProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SelectCategoryViewProtocols: class {
    var presenter: SelectCategoryPresenterProtocols? { get set }
    
    //PRESENTER -> VIEW
    func showCategory()
    
    //VIEW -> PRESENTER
    func backTapped()
    func selected()
}

protocol SelectCategoryPresenterProtocols: class {
    var view: SelectCategoryViewProtocols? { get set }
    var wireFrame: SelectCategoryWireFrameProtocols? { get set }

    //VIEW -> PRESENTER
    func viewDidLoad()
    func go(selected: String)
    func back()
}

protocol SelectCategoryWireFrameProtocols: class {
    static func createSelectCategoryViewModul(category: [Category]) -> UIViewController
    
    func goToCreateStudy(view: UIViewController, category: String)
    func backToStudyMain(view: UIViewController)
}
