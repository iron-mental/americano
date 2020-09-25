//
//  CreateStudyWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyWireFrame: CreateStudyWireFrameProtocols {
    static func createStudyViewModul(category: Category) -> UIViewController {
        let view = CreateStudyView()
        let presenter = CreateStudyPresenter()
        let interactor = CreateStudyInteractor()
        
        view.presenter = presenter
        view.selectedCategory = category
        
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        view.seletedCategory = category
        
        return view
    }
}
