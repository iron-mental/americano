//
//  StudyDetailView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyDetailView: UIViewController {
    let state: [String] = ["공지사항", "스터디 정보", "채팅"]
    
    let tabButton = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        tabButton.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(tabButtonCell.self, forCellWithReuseIdentifier: tabButtonCell.cellID)
        }
    }
    
    func layout() {
        view.addSubview(tabButton)
        
        tabButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 38)).isActive = true
        }
    }
}

extension StudyDetailView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabButton.dequeueReusableCell(withReuseIdentifier: tabButtonCell.cellID, for: indexPath) as! tabButtonCell
        
        cell.state.text = state[indexPath.row]
        
        return cell
    }
    
    
}
