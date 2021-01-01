//
//  ProjectModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/01.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ProjectModifyPresenter: ProjectModifyPresenterProtocol {
    var view: ProjectModifyViewProtocol?
    var interactor: ProjectModifyInteractorInputProtocol?
    var wireFrame: ProjectModifyWireFrameProtocol?
    
    func completeModify(title: String, contents: String) {
        
    }
    
}

extension ProjectModifyPresenter: ProjectModifyInteractorOutputProtocol {
    func didCompleteModify(result: Bool, message: String) {
        
    }
}
