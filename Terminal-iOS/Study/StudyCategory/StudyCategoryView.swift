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
    lazy var searchStudyBtn = UIBarButtonItem()
    lazy var createStudyBtn = UIBarButtonItem()
    let categoryCollectionView: UICollectionView = {
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
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.navigationController?.navigationBar.standardAppearance = appearance
            $0.title = "스터디"
            $0.navigationItem.rightBarButtonItems = [createStudyBtn, searchStudyBtn]
        }
        self.searchStudyBtn.do {
            $0.image = UIImage(systemName: "magnifyingglass")?
                .withConfiguration(UIImage.SymbolConfiguration(weight: .regular))
            $0.action = #selector(searchStudy)
            $0.target = self
        }
        self.createStudyBtn.do {
            $0.image = UIImage(systemName: "plus")?
                .withConfiguration(UIImage.SymbolConfiguration(weight: .regular))
            $0.action = #selector(createStudy)
            $0.target = self
        }
        categoryCollectionView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.categoryCellID)
            $0.delegate = self
            $0.dataSource = self
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    func layout() {
        view.addSubview(categoryCollectionView)
        
        categoryCollectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: Terminal.convertWidth(value: 20)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                             constant: -(Terminal.convertWidth(value: 20))).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    @objc func createStudy() {
        presenter?.didClickedCreateButton()
    }
    @objc func searchStudy() {
        presenter?.goToSearchStudy()
    }
}

extension StudyCategoryView: StudyCategoryViewProtocol {
    func showCategoryList(with category: [Category]) {
        categoryList = category
        categoryCollectionView.reloadData()
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
    
    func categoryDownAnimate() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
            self.categoryCollectionView.transform
                = self.categoryCollectionView.transform.translatedBy(x: 0, y: 60)
        }, completion: { _ in
            self.presenter?.goToCreateStudy(category: self.categoryList)
        })
    }
    
    func categoryUpAnimate() {
        categoryCollectionView.transform = self.categoryCollectionView.transform.translatedBy(x: 0, y: -60)
    }
}

extension StudyCategoryView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Terminal.convertWidth(value: 150),
                      height: Terminal.convertWidth(value: 100))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Terminal.convertWidth(value: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Terminal.convertWidth(value: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.categoryCellID, for: indexPath) as! CategoryCell
        let category = categoryList[indexPath.row]
        cell.setData(category: category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categoryList[indexPath.row].name
        presenter?.showStudyListDetail(category: category)
    }
}
