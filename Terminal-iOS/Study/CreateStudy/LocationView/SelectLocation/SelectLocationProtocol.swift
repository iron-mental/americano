//
//  selectLocationProtocol.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import NMapsMap

protocol SelectLocationViewProtocol: class {
    var presenter: SelectLocationPresenterProtocol? { get set }
    var delegate: selectLocationDelegate? { get set }
    // PRESENTER -> VIEW
    func setViewWithResult(item: StudyDetailLocationPost)
    func setLocaionOnce(sido: String, sigungu: String)
    func showError(message: String)
}

protocol SelectLocationInteractorProtocol: class {
    var presenter: SelectLocationPresenterProtocol? { get set }
    var remoteDataManager: SelectLocationRemoteDataManagerProtocol? { get set }
    var localDataManager: SelectLocationLocalDataManagerProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func searchAddressOnce(item: StudyDetailLocationPost)
    func searchAddress(item: StudyDetailLocationPost)
    func selectLocation(item: StudyDetailLocationPost)
    
    // DATAMANAGER -> INTERACTOR
    func sessionTaskError(message: String)
}

protocol SelectLocationPresenterProtocol: class {
    var view: SelectLocationViewProtocol? { get set }
    var interactor: SelectLocationInteractorProtocol? { get set }
    var wireFrame: SelectLocationWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func getAddress(item: StudyDetailLocationPost)
    func searchAddressOnceResult(sido: String, sigungu: String)
    func didClickedCompletButton(item: StudyDetailLocationPost)
    func viewDidLoad(item: StudyDetailLocationPost)
    
    // INTERACTOR -> PRESENTER
    func getAddressResult(item: StudyDetailLocationPost)
    func sessionTaskError(message: String)
}

protocol SelectLocationRemoteDataManagerProtocol: class {
    var interactor: SelectLocationInteractorProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func getAddressInfoOnce(lat: Double,
                            lng: Double,
                            completion: @escaping (Bool, _ sido: String?, _ sigungu: String?) -> Void)
    func getAddressInfo(lat: Double,
                        lng: Double,
                        completion: @escaping (_: Bool, _ item: StudyDetailLocationPost?) -> Void)
}

protocol SelectLocationLocalDataManagerProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}

protocol SelectLocationWireFrameProtocol: class {    
    static func selectLocationViewModule(item: StudyDetailLocationPost, parentView: UIViewController) -> UIViewController
}
