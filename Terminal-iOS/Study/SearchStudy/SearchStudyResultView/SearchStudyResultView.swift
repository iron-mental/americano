//
//  SearchStudyResultView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SearchStudyResultView: UIViewController {
    var presenter: SearchStudyResultPresenterProtocol?
    var keyword: String?
    var studyListTableView = UITableView()
    var searchResult: [Study] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.returnDidTap(keyWord: keyword!)
        attribute()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        presenter?.returnDidTap(keyWord: keyword!)
//        attribute()
    }
    func attribute() {
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            if let title = keyword {
                $0.title = "\(title) 에 대한 검색결과"
            }
        }
        navigationItem.do {
            $0.hidesSearchBarWhenScrolling = true
            $0.searchController = searchController
            $0.largeTitleDisplayMode = .never
        }
        searchController.do {
            $0.obscuresBackgroundDuringPresentation = true
            $0.searchBar.placeholder = "키워드를 검색하세요"
            $0.searchBar.tintColor = UIColor(named: "default")
            definesPresentationContext = true
            $0.searchBar.delegate = self
            $0.searchBar.showsCancelButton = true
        }
        self.studyListTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.prefetchDataSource = self
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(StudyCell.self, forCellReuseIdentifier: StudyCell.cellId)
            $0.rowHeight = 105
        }
    }
    
    func layout() {
        [ studyListTableView ].forEach { view.addSubview($0) }

        studyListTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: false)
    }
}

extension SearchStudyResultView: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths where searchResult.count - 1 == indexPath.row {
            presenter?.scrollToBottom()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudyCell.cellId, for: indexPath) as! StudyCell
        cell.setData(searchResult[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyValue = searchResult[indexPath.row].id
        presenter?.didTapCell(keyValue: keyValue, state: searchResult[indexPath.row].isMember!)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension SearchStudyResultView: SearchStudyResultViewProtocol {    
    
    func showLoading() {
        LoadingRainbowCat.show()
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide {
            print("고양이 끝")
        }
    }
    
    func showSearchStudyListResult(result: [Study], completion: @escaping () -> Void) {
        searchResult = result
        studyListTableView.reloadData()
        if !result.isEmpty { studyListTableView.scrollToRow(at: [0, 0], at: .none, animated: false) }
        completion()
    }
    
    func showPagingStudyListResult(result: [Study]) {
        searchResult += result
        studyListTableView.reloadData()
    }
}

extension SearchStudyResultView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        keyword = searchBar.text!
        attribute()
        presenter?.returnDidTap(keyWord: searchBar.text!)
        view.endEditing(true)
    }
}

extension SearchStudyResultView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        
    }
}
