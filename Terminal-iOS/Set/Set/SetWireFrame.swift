//
//  SetWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/07.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SetWireFrame: SetWireFrameProtocol {
    static func setCreateModule() -> UIViewController {
        let view: SetViewProtocol = SetView()
        let presenter: SetPresenterProtocol & SetInteractorOutputProtocol = SetPresenter()
        let interactor: SetInteractortInputProtocol & SetRemoteDataManagerOutputProtocol = SetInteractor()
        let wireFrame: SetWireFrameProtocol = SetWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        print("여긴되냐?")
        if let view = view as? SetView {
            return view
        } else {
            return UIViewController()
        }
    }
    
    func presentProfileDetailScreen(from view: SetViewProtocol) {
        let profileDetailView = ProfileDetailWireFrame.createModule()

        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(profileDetailView, animated: true)
        }
    }
}
