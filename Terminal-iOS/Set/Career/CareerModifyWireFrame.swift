//
//  CareerModifyWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CareerModifyWireFrame: CareerModifyWireFrameProtocol {
    static func createModule(title: String, contents: String) -> UIViewController {
        let view: CareerModifyViewProtocol = CareerModifyView()
        let presenter: CareerModifyPresenterProtocol & CareerModifyInteractorOutputProtocol = CareerModifyPresenter()
        let interactor: CareerModifyInteractorInputProtocol = CareerModifyInteractor()
        let wireFrame: CareerModifyWireFrameProtocol = CareerModifyWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
       
        if let view = view as? CareerModifyView {
            view.careerTitle = title
            view.careerContents = contents
            return view
        } else {
            return UIViewController()
        }
    }
}
