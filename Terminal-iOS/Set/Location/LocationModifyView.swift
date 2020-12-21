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
        self.locationLabel.do {
            $0.text = "활동지역"
            $0.textColor = .white
        }
        self.locationTextField.do {
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.addLeftPadding()
        }
    }
    
    func layout() {
        self.view.addSubview(locationLabel)
        self.view.addSubview(locationTextField)
        
        self.locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        }
        self.locationTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 7).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        }
    }
}

extension LocationModifyView: LocationModifyViewProtocol {
    
}
