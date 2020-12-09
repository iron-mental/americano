//
//  SelectCategoryWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectCategoryWireFrame: SelectCategoryWireFrameProtocol {
    static func createSelectCategoryViewModul(category: [Category]) -> UIViewController {
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
        
        let createStudyView = CreateStudyWireFrame.createStudyViewModul(category: category.name, studyDetail: nil, state: .create, parentView: nil)
        
        createStudyView.hidesBottomBarWhenPushed = true
        view.navigationController?.pushViewController(createStudyView, animated: false)
    }
    
    func backToStudyMain(view: UIViewController) {
        let studyMainView = StudyCategoryWireFrame.createStudyCategory()
        view.navigationController?.pushViewController(studyMainView, animated: false)
        view.navigationController?.popViewController(animated: false)
    }
}
