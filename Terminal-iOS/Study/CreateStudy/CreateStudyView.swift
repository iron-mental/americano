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
    
    let screenSize = UIScreen.main.bounds
    var selectedCategory: String?
    
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    let studyTitleTextField = UITextField()
    let collectionView = SNSCollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
    
    
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
        scrollView.do {
            $0.backgroundColor = .cyan
        }
        imageView.do {
            $0.image = #imageLiteral(resourceName: "swiftBackground")
        }
        studyTitleTextField.do {
            $0.placeholder = "스터디 이름"
            $0.backgroundColor = .white
            $0.textAlignment = .center
            $0.textColor = .black
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(studyTitleTextField)
        scrollView.addSubview(collectionView)
        
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            $0.contentSize = CGSize(width: screenSize.width, height: 2000)
        }
        imageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (170/667) * screenSize.height).isActive = true
            $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        }
        studyTitleTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (300/375) * screenSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (55/667) * screenSize.height).isActive = true
            $0.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: -((((55/667) * screenSize.height) * 16) / 55)).isActive = true
        }
        collectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo:scrollView.centerXAnchor)
                .isActive = true
            $0.centerYAnchor.constraint(equalTo:scrollView.centerYAnchor, constant: 200)
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
