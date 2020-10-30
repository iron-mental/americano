//
//  TempStudyDetailViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class TempStudyDetailViewController: UIViewController {
    var mainImageView = MainImageView(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    func layout() {
        [mainImageView].forEach { view.addSubview($0) }
        mainImageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 169)).isActive = true
        }
    }
}
