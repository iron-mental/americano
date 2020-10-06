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

}

protocol SelectLocationPresenterProtocol: class {

}

protocol SelectLocationRemoteDataManagerProtocol: class {

}

protocol SelectLocationLocalDataManagerProtocol: class {

}

protocol SelectLocationWireFrameProtocol: class {

}
