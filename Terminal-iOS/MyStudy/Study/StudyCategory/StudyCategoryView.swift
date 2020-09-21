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
            $0.view.backgroundColor = .white
            $0.title = "스터디"
            $0.navigationItem.rightBarButtonItems = [createStudyBtn, searchStudyBtn]
            $0.navigationController?.navigationBar.do {
                $0.barTintColor = .white
                $0.titleTextAttributes = [.foregroundColor: UIColor.white]
            }
        }
        
        collectionView.do {
            $0.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor(named: "background")
        }
    }
    
    func layout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.053).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -(UIScreen.main.bounds.width * 0.053)).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func createStudy() {
        presenter?.didClickedCreateButton()
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
    func categoryDownAnimate() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
            self.collectionView.transform = self.collectionView.transform.translatedBy(x: 0, y: 60)
        },completion: { _ in
            self.presenter?.goToCreateStudy(category: self.categoryList)
        })
    }
    
    func categoryUpAnimate() {
        collectionView.transform = self.collectionView.transform.translatedBy(x: 0, y: -60)
    }
}

extension StudyCategoryView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width * 0.4,
                      height: UIScreen.main.bounds.width * 0.27)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.width * 0.07
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.height * 0.035
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
        print(indexPath)
    }
}
