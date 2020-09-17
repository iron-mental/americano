//
//  StudyViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class StudyCategoryView: UIViewController {

    var presenter: StudyCategoryPresenterProtocol?
    var categoryList: [Category] = []

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attirbute()
        layout()
        presenter?.viewDidLoad()
    }
    
    func attirbute() {
        
        let createStudyBtn = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(createStudy))
        let searchStudyBtn = UIBarButtonItem(barButtonSystemItem: .search,
                                             target: self,
                                             action: #selector(searchStudy))
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.title = "스터디"
            $0.navigationItem.rightBarButtonItems = [createStudyBtn, searchStudyBtn]
            $0.navigationController?.navigationBar.do {
                $0.barTintColor = UIColor.appColor(.terminalBackground)
                $0.titleTextAttributes = [.foregroundColor: UIColor.white]
            }
        }
        
        collectionView.do {
            $0.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
    }
    
    func layout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 23).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -23).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func createStudy() {
        let view = CreateStudyViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    @objc func searchStudy() {
        let view = SearchStudyViewController()
        present(view, animated: true, completion: nil)
    }
}

extension StudyCategoryView: StudyCategoryViewProtocol {
    
    func showCategoryList(with category: [Category]) {
        categoryList = category
        collectionView.reloadData()
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}

extension StudyCategoryView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(view.frame.width)
        return CGSize(width: collectionView.frame.width / 2 - 20,
                      height: view.frame.height / 8 - 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 29
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        
        let category = categoryList[indexPath.row]
        cell.imageView.image = category.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showStudyListDetail()
    }
}
