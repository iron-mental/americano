//
//  MyApplyListWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyApplyListWireFrame: MyApplyListWireFrameProtocol {
    static func createStudyListModule() -> UIViewController {
        let view: MyApplyListViewProtocol = MyApplyListView()
        let presenter: MyApplyListPresenterProtocol & MyApplyListInteractorOutputProtocol = MyApplyListPresenter()
        let interactor: MyApplyListInteractorInputProtocol = MyApplyListInteractor()
        let wireFrame: MyApplyListWireFrameProtocol = MyApplyListWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        if let view = view as? MyApplyListView {
            return view
        } else {
            return UIViewController()
        }
    }
    
    func presentStudyDetailScreen(from view: MyApplyListViewProtocol, studyID: Int) {
        let studyDetailViewController = MyApplyStudyModifyWireFrame.createMyApplyStudyModifyModule(studyID: studyID)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(studyDetailViewController, animated: true)
        }
    }
}
