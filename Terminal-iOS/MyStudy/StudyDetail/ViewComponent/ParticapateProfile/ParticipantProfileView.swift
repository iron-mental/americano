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
    
    override func layout() {
        super.layout()
        
        self.location.do {
            $0.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        }
    }
}

extension ParticipantProfileView: ParticipantProfileViewProtocol {
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
}
