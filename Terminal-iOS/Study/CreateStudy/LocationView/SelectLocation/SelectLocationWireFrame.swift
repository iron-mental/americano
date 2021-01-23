//
//  SelectLocationWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectLocationWireFrame: SelectLocationWireFrameProtocol {
    var presenter: SelectLocationPresenterProtocol?
    
    static func selectLocationViewModul(item: StudyDetailLocationPost, parentView: UIViewController) -> UIViewController {
        let view = SelectLocationView()
        view.location = item
        print(view.location)
        
        view.delegate = parentView as? selectLocationDelegate
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
