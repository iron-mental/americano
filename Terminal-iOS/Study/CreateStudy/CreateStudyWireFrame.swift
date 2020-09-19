//
//  CreateStudyWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyWireFrame: CreateStudyWireFrameProtocols {
    static func createStudyViewModul() -> UIViewController {
        let view = CreateStudyView()
        let presenter = CreateStudyPresenter()
        let interactor = CreateStudyInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
}
