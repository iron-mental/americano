//
//  LocationModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class LocationModifyView: UIViewController {
    var presenter: LocationModifyPresenterProtocol?
    
    lazy var locationLabel = UILabel()
    lazy var locationTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.view.backgroundColor = .appColor(.terminalBackground)
        self.locationLabel.do {
            $0.text = "활동지역"
            $0.textColor = .white
        }
        self.locationTextField.do {
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.layer.cornerRadius = 10
            $0.placeholder = "활동지역 입력"
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.addLeftPadding()
        }
    }
    
    func layout() {
        self.view.addSubview(locationLabel)
        self.view.addSubview(locationTextField)
        
        self.locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        }
        self.locationTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 7).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
    }
}

extension LocationModifyView: LocationModifyViewProtocol {
    
}
