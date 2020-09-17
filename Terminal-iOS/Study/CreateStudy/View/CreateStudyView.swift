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
    var testUIView = UIView()
    var collectionView = SNSCollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
    var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor(named: "background")
        }
    }
    
    func layout() {
        view.addSubview(collectionView)
        collectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo:view.centerXAnchor)
                .isActive = true // ---- 1
            $0.centerYAnchor.constraint(equalTo:view.centerYAnchor)
                .isActive = true // ---- 2
            $0.heightAnchor.constraint(equalToConstant: 200)
                .isActive = true // ---- 3
            $0.widthAnchor.constraint(equalToConstant: 200)
                .isActive = true // ---- 4
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SNSCollectionViewCell.identifier , for: indexPath)
        return cell
    }
}

extension CreateStudyView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
