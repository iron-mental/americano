//
//  ProjectModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/01.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class ProjectModifyWireFrame: ProjectModifyWireFrameProtocol {
    static func createModule(project: [Project]) -> UIViewController {
        let view: ProjectModifyViewProtocol = ProjectModifyView()
        let presenter: ProjectModifyPresenterProtocol & ProjectModifyInteractorOutputProtocol = ProjectModifyPresenter()
        let wireFrame: ProjectModifyWireFrameProtocol = ProjectModifyWireFrame()
        let interactor: ProjectModifyInteractorInputProtocol = ProjectModifyInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        if let view = view as? ProjectModifyView {
            view.projectArr = project
            return view
        } else {
            return UIViewController()
        }
    }
}
