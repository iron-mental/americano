//
//  SelectLocationWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectLocationWireFrame: SelectLocationWireFrameProtocols {
    var presenter: SelectLocationPresenterProtocols?
    
    static func selectLocationViewModul(item: searchLocationResult) -> UIViewController {
        var view = SelectLocationView()
        view.location = item
        let interactor = SelectLocationInteractor()
        let presenter = SelectLocationPresenter()
        let remoteDataManager = SelectLocationRemoteDataManager()
        let localDataManager = SelectLocationLocalDataManager()
        let wireFrame = SelectLocationWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.localDataManager = localDataManager
        interactor.remoteDataManager = remoteDataManager
        
        wireFrame.presenter = presenter
        
        //여기서 view presenter 어쩌고 저쩌고 다할당 시켜서 리턴
        return view
    }
}
