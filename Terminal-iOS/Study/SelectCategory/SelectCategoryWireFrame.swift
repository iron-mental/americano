//
//  SelectCategoryWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class SelectCategoryWireFrame: SelectCategoryWireFrameProtocol {
    static func createSelectCategoryViewModule(category: [Category]) -> UIViewController {
        let view = SelectCategoryView()
        let presenter: SelectCategoryPresenterProtocol = SelectCategoryPresenter()
        let wireFrame: SelectCategoryWireFrameProtocol = SelectCategoryWireFrame()
        
        view.presenter = presenter
        view.categoryList = category
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        
        return view
    }
    
    func goToCreateStudy(view: UIViewController, category: Category) {
        let createStudyView = CreateStudyWireFrame.createStudyViewModule(category: category.name,
                                                                         studyDetail: nil,
                                                                         parentView: nil)
        view.navigationController?.pushViewController(createStudyView, animated: true)
    }
    
    func backToStudyMain(view: UIViewController) {
        let studyMainView = StudyCategoryWireFrame.createStudyCategory()
        view.navigationController?.pushViewController(studyMainView, animated: false)
        view.navigationController?.popViewController(animated: false)
    }
}
