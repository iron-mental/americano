//
//  CreateStudyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyView: UIViewController {
    var presenter: CreateStudyPresenterProtocols?
    var selectedCategory: String?
    var collectionView = UICollectionView()
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor(named: "background")
        }
        
    }
    
    func layout() {
        view.addSubview(collectionView)
        
        collectionView.do {
            $0.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        }
    }
}

extension CreateStudyView: CreateStudyViewProtocols {
    func setView() {
        attribute()
        layout()
    }
    
    func getBackgroundImage() {
        print("getBackgroundImage")
    }
    
    func setBackgroundImage() {
        print("setVackgroundImage")
    }
}

extension CreateStudyView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return 6
    }
    
    
}

extension CreateStudyView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
