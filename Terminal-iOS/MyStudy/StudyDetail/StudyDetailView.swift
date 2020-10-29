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
    
    lazy var tabButton: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    lazy var tabSege = UISegmentedControl(items: state)
    lazy var selectedUnderLine = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        tabButton.do {
            $0.backgroundColor = .black
            $0.delegate = self
            $0.dataSource = self
            $0.register(tabButtonCell.self, forCellWithReuseIdentifier: tabButtonCell.cellID)
        }
        tabSege.do {
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.gray], for: .normal)
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white], for: .selected)
            $0.backgroundColor = .clear
            $0.tintColor = .white
            $0.selectedSegmentTintColor = .clear
        }
        selectedUnderLine.do {
            $0.backgroundColor = .white
        }
    }
    
    func layout() {
        view.addSubview(tabButton)
        view.addSubview(tabSege)
        view.addSubview(selectedUnderLine)
        
        tabButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 38)).isActive = true
        }
        tabSege.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: tabButton.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 38)).isActive = true
        }
        selectedUnderLine.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: tabSege.bottomAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: tabSege.centerXAnchor, constant: -view.frame.width / 3).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 3).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
}

extension StudyDetailView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width / 3 - 2, height: Terminal.convertHeigt(value: 38))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return state.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabButton.dequeueReusableCell(withReuseIdentifier: tabButtonCell.cellID, for: indexPath) as! tabButtonCell
        
        cell.state.text = state[indexPath.row]
        
        return cell
    }
}
