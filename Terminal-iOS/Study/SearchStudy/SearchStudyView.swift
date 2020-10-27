//
//  SearchStudyViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/02.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class SearchStudyView: UIViewController {
    
    var keyword: [String] = ["안드로이드ㅇㅇㅇㅇㅇㅇㅇ", "node.js", "코드리뷰", "취업스터디", "프로젝트", "Swift", "갓우석님", "예비유니콘케어닥fffff", "뭐지??왜안나옴"]
        
    let backBtn = UIButton()
    let searchBar = UISearchBar()
    let placeSearch = UIButton()
    let hotLable = UILabel()
    let tempView = UIView()
    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.terminalBackground)
        attribute()
        layout()
    }
    
    func attribute() {
        backBtn.do {
            $0.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
            $0.addTarget(self, action: #selector(back), for: .touchUpInside)
        }
        searchBar.do {
            $0.placeholder = "스터디명, 분류(키워드) 등"
            $0.barTintColor = UIColor.appColor(.terminalBackground)
        }
        placeSearch.do {
            $0.setTitle("장소로 검색", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.layer.cornerRadius = 10
        }
        hotLable.do {
            $0.text = "핫 등록 키워드"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 14, weight: .semibold)
        }
        collectionView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(HotKeywordCell.self, forCellWithReuseIdentifier: HotKeywordCell.cellId)
            $0.delegate = self
            $0.dataSource = self
        }
        tempView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
    }
    
    func layout() {
        view.addSubview(backBtn)
        view.addSubview(searchBar)
        view.addSubview(placeSearch)
        view.addSubview(hotLable)
        view.addSubview(tempView)
        view.addSubview(collectionView)
        
        backBtn.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                    constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                        constant: 10).isActive = true
        }
        searchBar.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        placeSearch.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 115).isActive = true
        }
        hotLable.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: placeSearch.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        }
        tempView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: hotLable.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 400).isActive = true
        }
        collectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: tempView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempView.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: tempView.bottomAnchor).isActive = true
        }
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
}


extension SearchStudyView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let key = keyword[indexPath.row]
        
        let height = UIScreen.main.bounds.height * 0.045
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        let size = CGSize(width: 1000, height: height)
        let estimatedFrame = NSString(string: key).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return CGSize(width: estimatedFrame.width + 50, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyword.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotKeywordCell.cellId, for: indexPath) as! HotKeywordCell
        
        cell.keyword.setTitle(keyword[indexPath.row], for: .normal)
        
        return cell
    }
    
    class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            let attributes = super.layoutAttributesForElements(in: rect)

            var leftMargin = sectionInset.left
            var maxY: CGFloat = -1.0
            attributes?.forEach { layoutAttribute in
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }

                layoutAttribute.frame.origin.x = leftMargin

                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY , maxY)
            }

            return attributes
        }
    }
}
