//
//  ProfileModifyProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol ProfileModifyViewProtocol: class {
    var presenter: ProfileModifyPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func modifyResultHandle(result: Bool, message: String)
    func showError(message: String, label: String?)
    func showLoading()
    func hideLoading()
}

protocol ProfileModifyWireFrameProtocol: class {
    static func createProfileModifyModule(profile: Profile) -> UIViewController
    
    // PRESENTER -> WIREFRAME
}

protocol ProfileModifyPresenterProtocol: class {
    var view: ProfileModifyViewProtocol? { get set }
    var interactor: ProfileModifyInteractorInputProtocol? { get set }
    var wireFrame: ProfileModifyWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func completeImageModify(image: UIImage, profileExistence: Bool)
    func completeModify(profile: Profile)
}

protocol ProfileModifyInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didCompleteModify(result: Bool, message: String)
    func sessionTaskError(message: String)
    func modifyFailed(message: String, label: String)
}

protocol ProfileModifyInteractorInputProtocol: class {
    var presenter: ProfileModifyInteractorOutputProtocol? { get set }
    var remoteDataManager: ProfileModifyRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func viewDidLoad()
    func completeImageModify(image: UIImage, profileExistence: Bool)
    func completeModify(profile: Profile)
}

protocol ProfileModifyRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ProfileModifyRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func authCheck(completion: @escaping () -> Void)
    func retrieveImageModify(image: UIImage, profileExistence: Bool)
    func retrieveNicknameModify(profile: [String: String])
    func refreshToken()
}

protocol ProfileModifyRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func imageModifyRetrieved(result: BaseResponse<Bool>)
    func nicknameModifyRetrieved(result: BaseResponse<Bool>)
    func mergeProfileModifyResult()
    func sessionTaskError(message: String)
}
