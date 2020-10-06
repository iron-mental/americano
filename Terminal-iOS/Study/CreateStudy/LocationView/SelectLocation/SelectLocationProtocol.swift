//
//  selectLocationProtocol.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SelectLocationViewProtocol: class {
    var presenter: SelectLocationPresenterProtocol { get set }
}

protocol SelectLocationInteractorProtocol: class {
    var presenter: SelectLocationPresenterProtocol { get set }
    var remoteDataManager: SelectLocationRemoteDataManagerProtocol { get set }
    var localDataManager: SelectLocationLocalDataManagerProtocol { get set }
}

protocol SelectLocationPresenterProtocol: class {
    var view: SelectLocationViewProtocol { get set }
    var interactor: SelectLocationInteractorProtocol { get set }
    var wireFrame: SelectLocationWireFrameProtocol { get set }
}

protocol SelectLocationRemoteDataManagerProtocol: class {

}

protocol SelectLocationLocalDataManagerProtocol: class {

}

protocol SelectLocationWireFrameProtocol: class {
    var presenter: SelectLocationPresenterProtocol { get set }
}
