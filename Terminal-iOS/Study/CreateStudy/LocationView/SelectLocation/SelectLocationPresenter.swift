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
        print("접운채 이대로이렇게~ ㅠ힘껀안ㄴ아주겠어")
    }
    
    var view: SelectLocationViewProtocol?
    var interactor: SelectLocationInteractorProtocol?
    var wireFrame: SelectLocationWireFrameProtocol?
    
    func getAddress(item: StudyDetailLocationPost) {
        interactor?.searchAddress(item: item)
    }
    
    func getAddressResult(item: searchLocationResult) {
        print("presenter", item)
        view?.setViewWithResult(item: item)
    }
}
