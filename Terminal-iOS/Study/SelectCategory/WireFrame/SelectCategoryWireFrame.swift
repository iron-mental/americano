//
//  SelectCategoryWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectCategoryWireFrame: SelectCategoryWireFrameProtocols {
    static func createSelectCategoryViewModul(category: String) -> UIViewController {
        let view = SelectCategoryView()
        let presenter: SelectCategoryPresenterProtocols = SelectCategoryPresenter()
        let wireFrame: SelectCategoryWireFrameProtocols = SelectCategoryWireFrame()
        
        view.presenter = presenter
        view.tempCategory = category
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        
        return view
    }
    
    func goToCreateStudy(view: UIViewController) {
        let createStudyView = CreateStudyWireFrame.createStudyViewModul()
        view.navigationController?.pushViewController(createStudyView, animated: false)
    }
}
