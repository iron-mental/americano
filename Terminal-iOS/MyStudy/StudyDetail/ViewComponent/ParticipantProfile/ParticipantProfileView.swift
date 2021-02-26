//
//  ParticipantProfileView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/24.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ParticipantProfileView: BaseProfileView {
    var presenter: ParticipantProfilePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter?.viewDidLoad()
    }
    
    override func attribute() {
        super.attribute()
        
        [ profile.modify, career.modify, project.modify, sns.modify, email.modify, location.modify]
            .forEach { $0.isHidden = true}
    }
    override func layout() {
        super.layout()
        
        self.location.do {
            $0.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        }
    }
    override func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    override func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
}

extension ParticipantProfileView: ParticipantProfileViewProtocol {
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
}
