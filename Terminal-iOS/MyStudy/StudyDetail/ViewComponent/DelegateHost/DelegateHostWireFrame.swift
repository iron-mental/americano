//
//  DelegateHostWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class DelegateHostWireFrame: DelegateHostWireFrameProtocol {
    static func createDelegateHostmodule(studyID: Int) -> UIViewController {
        let view = DelegateHostView()
        var presenter: DelegateHostPresenterProtocol & DelegateHostInteractorOutputProtocol = DelegateHostPresenter()
    }
}
