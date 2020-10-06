//
//  CreateStudyWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyWireFrame: CreateStudyWireFrameProtocols {
    
    static func createStudyViewModul(category: Category) -> UIViewController {
        let view = CreateStudyView()
        let presenter = CreateStudyPresenter()
        let interactor = CreateStudyInteractor()
        let remoteDataManager = CreateStudyRemoteManager()
        let wireFrame = CreateStudyWireFrame()
        
        view.presenter = presenter
        view.selectedCategory = category
        
        presenter.view = view
        presenter.interactor = interactor
        
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.createStudyRemoteDataManager = remoteDataManager
        
        view.seletedCategory = category
        
        return view
    }
    
    func goToSelectLocation(view: UIViewController) {

        let selectLocationView =  SelectLocationWireFrame.selectLocationViewModul()
        
        //modal의 형태를 추후에 정하구요 dismiss 시켜주는 것 만으로 다시 원래 플로우인 스터디 생성 플로우로 돌아가게 하면 깔끔 할 것 같은 느낌
        view.present(selectLocationView, animated: true, completion: nil)
    }
}
