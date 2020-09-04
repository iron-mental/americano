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

    let backBtn = UIButton()
    let searchBar = UISearchBar()
    let placeSearch = UIButton()
    
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
        placeSearch.do {
            $0.setTitle("장소로 검색", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.borderWidth = 3
            $0.layer.cornerRadius = 10
        }
    }
    
    func layout() {
        view.addSubview(backBtn)
        view.addSubview(searchBar)
        view.addSubview(placeSearch)
        
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
        
        placeSearch.translatesAutoresizingMaskIntoConstraints = false
        placeSearch.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: 20).isActive = true
        placeSearch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        placeSearch.heightAnchor.constraint(equalToConstant: 40).isActive = true
        placeSearch.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
