//
//  ModifyStudyWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class ModifyStudyWireFrame: ModifyStudyWireFrameProtocol {
    static func createModifyStudyModule(study: StudyDetail,
                                        location: Location,
                                        mainImage: UIImage?) -> UIViewController {
        let view = ModifyStudyView()
        let presenter: ModifyStudyPresenterProtocol & ModifyStudyInteractorOutputProtocol = ModifyStudyPresenter()
        let interactor: ModifyStudyInteractorInputProtocol & ModifyStudyRemoteDataManagerOutputProtocol = ModifyStudyInteractor()
        let remoteDataManager: ModifyStudyRemoteDataManagerInputProtocol = ModifyStudyRemoteDataManager()
        let wireFrame = ModifyStudyWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager

        remoteDataManager.interactor = interactor
        
        let postLocation = StudyDetailLocationPost(address: location.addressName,
                                                   lat: Double(location.latitude)!,
                                                   lng: Double(location.longitude)!,
                                                   detailAddress: location.locationDetail ?? "",
                                                   placeName: location.placeName ?? "",
                                                   category: "",
                                                   sido: "",
                                                   sigungu: "")
        view.study = study
        view.initImage = mainImage ?? nil
        view.selectedLocation = postLocation
        interactor.currentStudy = study
        
        return view
    }
    
    func goToSelectLocation(from view: ModifyStudyViewProtocol) {
        if let sourceView = view as? UIViewController {
            let searchLocationview = SearchLocationWireFrame.searchLocationViewModule(parentView: sourceView)
            searchLocationview.modalPresentationStyle = .fullScreen
            sourceView.present(searchLocationview, animated: true, completion: nil)
        }
    }
}
