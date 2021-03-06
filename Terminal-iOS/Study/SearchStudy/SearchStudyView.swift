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
    var keyword: [HotKeyword] = []
    var presenter: SearchStudyPresenterProtocol?
    let hotLable = UILabel()
    let titleLabel = UILabel()
    lazy var searchController = UISearchController(searchResultsController: nil)
    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        attribute()
        layout()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }
    
    func attribute() {
        self.do {
            $0.title = "스터디 검색"
        }
        self.navigationItem.do {
            $0.searchController = searchController
            $0.largeTitleDisplayMode = .always
            $0.titleView = titleLabel
            $0.backButtonTitle = ""
        }
        self.searchController.do {
            $0.hidesNavigationBarDuringPresentation = true
            $0.obscuresBackgroundDuringPresentation = false
            $0.automaticallyShowsCancelButton = false
            $0.searchBar.delegate = self
            navigationController!.navigationBar.sizeToFit()
            $0.hidesNavigationBarDuringPresentation = false
            $0.delegate = self
        }
        self.view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        self.hotLable.do {
            $0.text = "핫 등록 키워드"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 14, weight: .medium)
        }
        self.collectionView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(HotKeywordCell.self, forCellWithReuseIdentifier: HotKeywordCell.cellId)
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func layout() {
        [ hotLable, collectionView].forEach { self.view.addSubview($0) }
        
        self.hotLable.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        }
        self.collectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.hotLable.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
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
    func showHotkeyword(keyword: [HotKeyword]) {
        self.keyword = keyword
        collectionView.reloadData()
        if searchController.isActive {
            hideLoading()
        }
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
}

extension SearchStudyView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.didSearchButtonClicked(keyword: searchBar.text!)
    }
}

extension SearchStudyView: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
            if !self.keyword.isEmpty {
                self.hideLoading()
            }
        }
    }
}
