//
//  ParticipantProfileWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/24.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class ParticipantProfileWireFrame: ParticipantProfileWireFrameProtocol {
    static func createParticipantProfileModule(userInfo: Int) -> UIViewController {
        let view = ParticipantProfileView()
        let presenter: ParticipantProfilePresenterProtocol & ParticipantProfileInteractorOutputProtocol = ParticipantProfilePresenter()
        let interactor: ParticipantProfileInteractorInputProtocol & ParticipantProfileRemoteDataManagerOutputProtocol = ParticipantProfileInteractor()
        let remoteDataManager: ParticipantProfileRemoteDataManagerInputProtocol = ParticipantProfileRemoteDataManager()
        let wireFrame: ParticipantProfileWireFrameProtocol = ParticipantProfileWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.userID = userInfo
        
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
}
