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
    let hotLable = UILabel()
    let tempView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.terminalBackground)
        attribute()
        layout()
    }
    
    func attribute() {
        backBtn.do {
            $0.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
            $0.addTarget(self, action: #selector(back), for: .touchUpInside)
        }
        placeSearch.do {
            $0.setTitle("장소로 검색", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.borderWidth = 3
            $0.layer.cornerRadius = 10
        }
        hotLable.do {
            $0.text = "핫 등록 키워드"
            $0.textColor = .white
        }
        tempView.backgroundColor = .red
    }
    
    func layout() {
        view.addSubview(backBtn)
        view.addSubview(searchBar)
        view.addSubview(placeSearch)
        view.addSubview(hotLable)
        view.addSubview(tempView)
        
        backBtn.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                    constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                        constant: 10).isActive = true
        }
        searchBar.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        placeSearch.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
        hotLable.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: placeSearch.bottomAnchor, constant: 30).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        }
        tempView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: hotLable.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
}
