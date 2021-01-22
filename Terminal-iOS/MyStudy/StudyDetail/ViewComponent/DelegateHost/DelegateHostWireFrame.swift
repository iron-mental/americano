//
//  DelegateHostWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class DelegateHostWireFrame: DelegateHostWireFrameProtocol {
    static func createDelegateHostmodule(studyID: Int, userList: [Participate]) -> UIViewController {
        let view = DelegateHostView()
        var presenter: DelegateHostPresenterProtocol & DelegateHostInteractorOutputProtocol = DelegateHostPresenter()
        var interactor: DelegateHostInteractorInputProtocol & DelegateHostRemoteDataManagerOutputProtocol = DelegateHostInteractor()
        let remoteDataManager: DelegateHostRemoteDataManagerInputProtocol = DelegateHostRemoteDataManager()
        let wireFrame = DelegateHostWireFrame()
        
        view.presenter = presenter
        view.userList = userList
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.studyID = studyID
        
        return view
    }
}
