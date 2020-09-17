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
    
    let imageView = UIImageView()
    let screenSize = UIScreen.main.bounds
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
        imageView.do {
            $0.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: (170/667) * screenSize.height)
            $0.image = #imageLiteral(resourceName: "swiftBackground")
        }
    }
    
    func layout() {
        view.addSubview(imageView)
        view.addSubview(collectionView)
        
        imageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        collectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo:view.centerXAnchor)
                .isActive = true
            $0.centerYAnchor.constraint(equalTo:view.centerYAnchor)
                .isActive = true
            $0.heightAnchor.constraint(equalToConstant: 170)
                .isActive = true
            $0.widthAnchor.constraint(equalToConstant: screenSize.width )
                .isActive = true
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
