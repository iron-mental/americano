//
//  SearchStudyViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/02.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class SearchStudyView: UIViewController {
    
    let backBtn = UIButton()
    let searchBar = UISearchBar()
    let placeSearch = UIButton()
    let hotLable = UILabel()
    let tempView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
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
        searchBar.do {
            $0.placeholder = "스터디명, 분류(키워드) 등"
            $0.barTintColor = UIColor.appColor(.terminalBackground)
        }
        placeSearch.do {
            $0.setTitle("장소로 검색", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.layer.cornerRadius = 10
        }
        hotLable.do {
            $0.text = "핫 등록 키워드"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 14, weight: .semibold)
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
            $0.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 115).isActive = true
        }
        hotLable.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: placeSearch.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        }
        tempView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: hotLable.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }
        
        collectionView.do {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
}


extension SearchStudyView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
