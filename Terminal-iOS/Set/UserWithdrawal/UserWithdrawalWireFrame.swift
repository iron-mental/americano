//
//  UserWithdrawalWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class UserWithdrawalWireFrame: UserWithdrawalWireFrameProtocol {
    static func createModule() -> UIViewController {
        let view: UserWithdrawalViewProtocol = UserWithdrawalView()
        let presenter: UserWithdrawalPresenterProtocol & UserWithdrawalInteractorOutputProtocol = UserWithdrawalPresenter()
        let interactor: UserWithdrawalInteractorInputProtocol = UserWithdrawalInteractor()
        let wireframe: UserWithdrawalWireFrameProtocol = UserWithdrawalWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        if let view = view as? UserWithdrawalView {
            return view
        } else {
            return UIViewController()
        }
    }
}
