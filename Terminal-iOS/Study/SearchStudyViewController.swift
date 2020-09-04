//
//  SearchStudyViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/02.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class SearchStudyViewController: UIViewController {

    let backBtn = UIButton(type: .custom)
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        attribute()
        layout()
    }
    
    func attribute() {
        backBtn.do {
            $0.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        }
    }
    
    func layout() {
        view.addSubview(backBtn)
        view.addSubview(searchBar)
        
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                     constant: 10).isActive = true
        backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                         constant: 10).isActive = true

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 10).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
