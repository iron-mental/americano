//
//  SelectCategoryWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectCategoryWireFrame: SelectCategoryWireFrameProtocols {
    static func createSelectCategoryViewModul(category: [Category]) -> UIViewController {
        let view = SelectCategoryView()
        let presenter: SelectCategoryPresenterProtocols = SelectCategoryPresenter()
        let wireFrame: SelectCategoryWireFrameProtocols = SelectCategoryWireFrame()
        
        view.presenter = presenter
        view.categoryList = category
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        
        return view
    }
    
    func goToCreateStudy(view: UIViewController, category: Category) {
        let createStudyView = CreateStudyWireFrame.createStudyViewModul()
        
//        (createStudyView as! CreateStudyView).selectedCategory = category
        view.navigationController?.pushViewController(createStudyView, animated: false)
    }
    
    func backToStudyMain(view: UIViewController) {
        let studyMainView = StudyMainWireFrame.createStudyMainModule()
        view.navigationController?.pushViewController(studyMainView, animated: false)
        view.navigationController?.popViewController(animated: false)
    }
}
