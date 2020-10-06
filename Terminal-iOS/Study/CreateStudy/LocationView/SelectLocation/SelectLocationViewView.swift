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

    var nmapFView = NMFMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        nmapFView = NMFMapView(frame: view.frame)
        nmapFView.do {
            $0.mapType = .basic
            $0.symbolScale = 0.7
            $0.positionMode = .direction
        }
    }
    
    func layout() {
        view.addSubview(nmapFView)
    }
}

extension SelectLocationView: SelectLocationViewProtocols {
    func setViewWithResult(latLng: NMGLatLng, address: String) {
        print("setViewWithResult")
    }
}
