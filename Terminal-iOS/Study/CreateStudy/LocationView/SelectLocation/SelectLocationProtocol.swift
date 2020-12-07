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
    //PRESENTER -> VIEW
    func setViewWithResult(item: StudyDetailLocationPost)
    
}

protocol SelectLocationInteractorProtocol: class {
    var presenter: SelectLocationPresenterProtocol? { get set }
    var remoteDataManager: SelectLocationRemoteDataManagerProtocol? { get set }
    var localDataManager: SelectLocationLocalDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func searchAddress(item: StudyDetailLocationPost)
    func selectLocation(item: StudyDetailLocationPost)
}

protocol SelectLocationPresenterProtocol: class {
    var view: SelectLocationViewProtocol? { get set }
    var interactor: SelectLocationInteractorProtocol? { get set }
    var wireFrame: SelectLocationWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func getAddress(item: StudyDetailLocationPost)
    func didClickedCompletButton(item: StudyDetailLocationPost)
    func viewDidLoad(item: StudyDetailLocationPost)
    
    //INTERACTOR -> PRESENTER
    func getAddressResult(item: StudyDetailLocationPost)
}

protocol SelectLocationRemoteDataManagerProtocol: class {
    //INTERACTOR -> REMOTEDATAMANAGER
    func getAddressInfo(lat: Double, lng: Double, completion: @escaping (_: Bool, _ item: StudyDetailLocationPost?) -> ())
}

protocol SelectLocationLocalDataManagerProtocol: class {
    //INTERACTOR -> LOCALDATAMANAGER
}

protocol SelectLocationWireFrameProtocol: class {
    var presenter: SelectLocationPresenterProtocol? { get set }
    
    static func selectLocationViewModul(item: StudyDetailLocationPost, parentView: UIViewController) -> UIViewController
}
