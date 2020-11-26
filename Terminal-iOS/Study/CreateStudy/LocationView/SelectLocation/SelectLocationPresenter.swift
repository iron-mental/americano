//
//  SelectLocationPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import NMapsMap

class SelectLocationPresenter: SelectLocationPresenterProtocol {
    func didClickedCompletButton(item: StudyDetailLocationPost) {
    }
    
    var view: SelectLocationViewProtocol?
    var interactor: SelectLocationInteractorProtocol?
    var wireFrame: SelectLocationWireFrameProtocol?
    
    func getAddress(item: StudyDetailLocationPost) {
        interactor?.searchAddress(item: item)
    }
    
    func getAddressResult(item: StudyDetailLocationPost) {
        view?.setViewWithResult(item: item)
    }
}
