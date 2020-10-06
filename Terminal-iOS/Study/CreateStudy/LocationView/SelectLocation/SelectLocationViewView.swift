//
//  SelectLocationViewViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import NMapsMap

class SelectLocationView: UIViewController {
    var presenter: SelectLocationPresenterProtocols?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension SelectLocationView: SelectLocationViewProtocols {
    func setViewWithResult(latLng: NMGLatLng, address: String) {
        print("setViewWithResult")
    }
}
