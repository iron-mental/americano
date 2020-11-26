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
    lazy var tempButton = UIBarButtonItem(image: #imageLiteral(resourceName: "marker"), style: .plain, target: self, action: #selector(tempForStudyDetail))
    
    @objc func tempForStudyDetail() {
         let view = StudyDetailView()
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true)
    }
    
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
        let createStudyBtn = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(createStudy))
        let searchStudyBtn = UIBarButtonItem(barButtonSystemItem: .search,
                                             target: self,
                                             action: #selector(searchStudy))
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.navigationController?.navigationBar.standardAppearance = appearance
            $0.title = "스터디"
            $0.navigationItem.rightBarButtonItems = [createStudyBtn, searchStudyBtn]
        }
        categoryCollectionView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func layout() {
        view.addSubview(categoryCollectionView)
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        categoryCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.053).isActive = true
        categoryCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -(UIScreen.main.bounds.width * 0.053)).isActive = true
        categoryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    @objc func createStudy() {
        presenter?.didClickedCreateButton()
    }
    @objc func searchStudy() {
        let view = SearchStudyView()
        present(view, animated: true, completion: nil)
    }
}

extension StudyCategoryView: StudyCategoryViewProtocol {
    func showCategoryList(with category: [Category]) {
        categoryList = category
        categoryCollectionView.reloadData()
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    func categoryDownAnimate() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
            self.categoryCollectionView.transform = self.categoryCollectionView.transform.translatedBy(x: 0, y: 60)
        },completion: { _ in
            self.presenter?.goToCreateStudy(category: self.categoryList)
        })
    }
    
    func categoryUpAnimate() {
        categoryCollectionView.transform = self.categoryCollectionView.transform.translatedBy(x: 0, y: -60)
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
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        let category = categoryList[indexPath.row]
        cell.imageView.image = category.image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showStudyListDetail()
    }
}
