//
//  SelectCategoryView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class SelectCategoryView: UIViewController {
    var presenter: SelectCategoryPresenterProtocol?
    var categoryList: [Category] = []
    let scrollView = UIScrollView()
    let backgroundView = UIView()
    let textLabel = UILabel()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func attribute() {
        [backgroundView, scrollView].forEach { $0.backgroundColor = .appColor(.terminalBackground) }
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.title = "스터디 만들기"
        }
        
        self.textLabel.do {
            $0.text = "카테고리 선택"
            $0.textColor = .white
            $0.frame = CGRect(x: 0, y: 0, width: 90, height: 35)
            $0.dynamicFont(fontSize: 22, weight: .bold)
        }
        
        self.collectionView.do {
            $0.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.showsVerticalScrollIndicator = false
        }
        
        self.navigationItem.do {
            $0.backButtonTitle = "카테고리 선택"
            $0.leftBarButtonItem = UIBarButtonItem()
            $0.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light)),
                                                    style: .done,
                                                    target: self,
                                                    action: #selector(backButtonTapped))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            backButtonTapped()
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(textLabel)
        backgroundView.addSubview(collectionView)
        
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        backgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
        textLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 24).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                        constant: UIScreen.main.bounds.width).isActive = true
        }
        collectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 80).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                        constant: UIScreen.main.bounds.width * 0.053).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                         constant: -(UIScreen.main.bounds.width * 0.053)).isActive = true
            $0.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: $0.contentSize.height).isActive = true
        }
    }
    
    @objc func backButtonTapped() {
        presenter?.back()
    }
    
    func viewAppearAnimation() {
        UIView.animate(withDuration: 0.15, delay: 0, options: .transitionCurlUp, animations: { [self] in
            self.textLabel.transform = self.textLabel.transform.translatedBy(x: -(UIScreen.main.bounds.width - 10), y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .transitionCurlUp, animations: {
                self.textLabel.transform = self.textLabel.transform.translatedBy(x: 10, y: 0)
            }) { _ in
                UIView.animate(withDuration: 0.1, delay: 0, options: .transitionCurlUp, animations: {
                    self.textLabel.transform = self.textLabel.transform.translatedBy(x: -5, y: 0)
                })
            }
        }
    }
    
    func viewDisappearAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: { [self] in
            self.textLabel.transform = self.textLabel.transform.translatedBy(x: UIScreen.main.bounds.width, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
                self.collectionView.transform = self.collectionView.transform.translatedBy(x: 0, y: -60)
            }, completion: { _ in
                self.navigationController?.popViewController(animated: false)
            })
        }
    }
}

extension SelectCategoryView: SelectCategoryViewProtocol {
    func showCategory() {
        attribute()
        layout()
        viewAppearAnimation()
    }
    
    func backTapped() {
        viewDisappearAnimation()
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}

extension SelectCategoryView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        let category = categoryList[indexPath.row]
        cell.setData(category: category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.go(selected: categoryList[indexPath.row])
    }
}
