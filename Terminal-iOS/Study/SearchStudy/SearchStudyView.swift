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
    var presenter: SearchStudyPresenterProtocol?
    let hotLable = UILabel()
    var searchController = UISearchController(searchResultsController: nil)
    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.becomeFirstResponder()
        didload()
        attribute()
        layout()
    }
    
    func attribute() {
        self.searchController.do {
            $0.obscuresBackgroundDuringPresentation = false
            $0.searchBar.showsCancelButton = false
            $0.hidesNavigationBarDuringPresentation = false
            navigationItem.titleView = searchController.searchBar
            $0.searchBar.delegate = self
        }
        self.view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
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
    }
    
    //나중에 옮겨야함
    func didload() {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.hotKeyword)
            .validate()
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
        [hotLable, collectionView].forEach { self.view.addSubview($0) }
       
        self.hotLable.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        }
        self.collectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.hotLable.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                        constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                                         constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
        }
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
        self.searchController.searchBar.text = text
        presenter?.didSearchButtonClicked(keyword: text)
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
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
            return attributes
        }
    }
}

extension SearchStudyView: SearchStudyViewProtocol {
    
}

extension SearchStudyView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.didSearchButtonClicked(keyword: searchBar.text!)
    }
}
