//
//  StudyViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class StudyViewController: UIViewController {
    
    var temp = ["swift","android","tensorflow","node","frontend","jpark","swift","android","tensorflow","node","frontend","jpark"]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        attirbute()
        layout()
        view.backgroundColor = .white
        title = "스터디"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createStudy))
    }
    
    func attirbute() {
        collectionView.do {
            $0.register(StudyCell.self, forCellWithReuseIdentifier: "cell")
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .white
        }
    }
    
    func layout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    @objc func createStudy() {
        let view = CreateStudyViewController()
        navigationController?.pushViewController(view, animated: true)
    }
}

extension StudyViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.3, height: collectionView.frame.width / 3)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return temp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StudyCell
        cell.layer.cornerRadius = 10
        cell.imageView.image = UIImage(named: temp[indexPath.row])
        return cell
    }
}
