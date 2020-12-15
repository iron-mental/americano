//
//  SearchStudyViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/02.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then
import SwiftyJSON

class SearchStudyView: UIViewController {
    
    var keyword: [HotKeyword] = []
    
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
        searchBar.becomeFirstResponder()
        didload()
        attribute()
        layout()
    }
    
    func attribute() {
        self.view.do {
            let event = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
            event.cancelsTouchesInView = false
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.addGestureRecognizer(event)
        }
        self.backBtn.do {
            $0.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
            $0.addTarget(self, action: #selector(back), for: .touchUpInside)
        }
        self.searchBar.do {
            $0.placeholder = "스터디명, 분류(키워드) 등"
            $0.barTintColor = UIColor.appColor(.terminalBackground)
        }
        self.placeSearch.do {
            $0.setTitle("장소로 검색", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.layer.cornerRadius = 10
        }
        self.hotLable.do {
            $0.text = "핫 등록 키워드"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 14, weight: .semibold)
        }
        self.collectionView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(HotKeywordCell.self, forCellWithReuseIdentifier: HotKeywordCell.cellId)
            $0.delegate = self
            $0.dataSource = self
        }
        self.tempView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
    }
    
    func didload() {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.hotKeyword)
            .validate(statusCode: 200..<299)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<[HotKeyword]>.self, from: data!)
                    if let keyword = result.data {
                        self.keyword = keyword
                        self.collectionView.reloadData()
                    }
                case .failure(let err):
                    print(err)
                }
            }
    }
    
    func layout() {
        [backBtn, searchBar,placeSearch, hotLable, tempView, collectionView]
            .forEach { self.view.addSubview($0) }
        
        self.backBtn.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                    constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                        constant: 10).isActive = true
        }
        self.searchBar.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.backBtn.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        self.placeSearch.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 115).isActive = true
        }
        self.hotLable.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.placeSearch.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        }
        self.tempView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.hotLable.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 200).isActive = true
        }
        self.collectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.tempView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.tempView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.tempView.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.tempView.bottomAnchor).isActive = true
        }
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func backgroundTap() {
        self.view.endEditing(true)
    }
}


extension SearchStudyView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let key = keyword[indexPath.row].word
        
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
        
        let title = keyword[indexPath.row].word
        cell.keyword.setTitle(title, for: .normal)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let text = keyword[indexPath.row].word
        print(text)
        self.searchBar.text = text
    }
    
    class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            let attributes = super.layoutAttributesForElements(in: rect)
            
            var leftMargin = sectionInset.left
            var maxY: CGFloat = -1.0
            attributes?.forEach { layoutAttribute in
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                    print("포문",leftMargin)
                    
                }
                
                layoutAttribute.frame.origin.x = leftMargin
                
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                print("박,", leftMargin)
                maxY = max(layoutAttribute.frame.maxY , maxY)
            }
            
            return attributes
        }
    }
}
