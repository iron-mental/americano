//
//  SelectCategoryView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectCategoryView: UIViewController {
    
    var presenter: SelectCategoryPresenterProtocol?
    var categoryList: [Category] = []
    
    let scrollView = UIScrollView()
    let backgroundView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    let font = UIFont(name:"Apple Color Emoji" , size: 25)
    let titleView = UILabel()
    let textLabel = UILabel()
    var tempCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        titleView.do {
            $0.text = "스터디 만들기"
            $0.textColor = .white
        }
        navigationItem.do {
            $0.titleView = titleView
        }
        //추후에 스크롤뷰 위 백그라운드 뷰는 컴포넌트화 시켜서 코드를 줄여봅시다.
        scrollView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        backgroundView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        textLabel.do {
            $0.text = "카테고리 선택"
            $0.textColor = .white
            $0.frame = CGRect(x: 0, y: 0, width: 90, height: 35)
            let attributedStr = NSMutableAttributedString(string: textLabel.text ?? "empty")
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: font, range: NSMakeRange(0, 7))
            textLabel.attributedText = attributedStr
        }
        collectionView.do {
            $0.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        navigationItem.do {
            $0.leftBarButtonItem = UIBarButtonItem(title: "<<<<", style: .plain, target: self, action: #selector(backButtonTapped))
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
            //동적으로 추후에 변경해야함
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: scrollView.heightAnchor,constant: 50).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
        textLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 24).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 500).isActive = true
        }
        collectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 80).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: UIScreen.main.bounds.width * 0.053).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -(UIScreen.main.bounds.width * 0.053)).isActive = true
            $0.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: $0.contentSize.height).isActive = true
        }
    }
    
    @objc func backButtonTapped() {
        presenter?.back()
    }
    
    func viewAppearAnimation() {
        //애니메이션은 task 단위로 묶어서 하나 하는 중일 때 하나 들어오면 그전 꺼 취소하거나 그런식으로..
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCurlUp, animations: {
            self.textLabel.transform = self.textLabel.transform.translatedBy(x: -490, y: 0)
        })
        { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
                self.textLabel.transform = self.textLabel.transform.translatedBy(x: 10, y: 0)
            })
            { _ in
                UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
                    self.textLabel.transform = self.textLabel.transform.translatedBy(x: -5, y: 0)
                })
            }
        }
    }
    
    func viewDisappearAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCurlUp, animations: {
            self.textLabel.transform = self.textLabel.transform.translatedBy(x: 500, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
                self.collectionView.transform = self.collectionView.transform.translatedBy(x: 0, y: -60)
            },completion: { _ in
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
}

extension SelectCategoryView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        cell.imageView.image = category.image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.go(selected: categoryList[indexPath.row])
    }
}
