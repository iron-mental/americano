//
//  SearchLocationProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SearchLocationViewProtocol: class {
    var presenter: SearchLocationPresenterProtocol? { get set }
    func dismiss()
}

protocol SearchLocationPresenterProtocol: class {
    var view: SearchLocationViewProtocol? { get set }
    var interactor: SearchLocationInteractorProtocol? { get set }
    var wireFrame: SearchLocationWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    //추후에 index가 아닌 remoteDataManager로 부터 받아온 정보중 좌표값을 넘겨주어야 할듯 하네요
    func didSelectedItem(index: Int, view: UIViewController)
}

protocol SearchLocationInteractorProtocol: class {
    var remoteDataManager: SearchLocationRemoteDataManagerProtocol? { get set }
}

protocol SearchLocationRemoteDataManagerProtocol: class {
    
}

protocol SearchLocationWireFrameProtocol: class {
    var presenter : SearchLocationPresenterProtocol? { get set }
    
    //PRESENTER -> WIREFRAME
    func goToSelectLocationView(view: UIViewController)
}

