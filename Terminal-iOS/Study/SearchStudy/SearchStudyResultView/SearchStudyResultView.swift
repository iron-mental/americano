//
//  SearchStudyResultView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class SearchStudyResultView: UIViewController {
    var presenter: SearchStudyResultPresenterProtocol?
    var keyword: String?
    var searchResult: [Study] = []
    let searchController = UISearchController(searchResultsController: nil)
    let studyListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.returnDidTap(keyWord: keyword!)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.view.backgroundColor = .appColor(.terminalBackground)
            if let title = keyword {
                $0.title = "\(title) 에 대한 검색결과"
            }
        }
        navigationController?.do {
            $0.navigationBar.standardAppearance.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        navigationItem.do {
            $0.hidesSearchBarWhenScrolling = false
            $0.searchController = searchController
            $0.largeTitleDisplayMode = .never
            $0.backButtonTitle = ""
        }
        searchController.do {
            $0.hidesNavigationBarDuringPresentation = false
            $0.obscuresBackgroundDuringPresentation = false
            $0.automaticallyShowsCancelButton = false
            $0.searchBar.delegate = self
            $0.searchBar.placeholder = "키워드를 검색하세요"
            definesPresentationContext = true
            $0.searchBar.searchTextField.text = keyword
            
        }
        self.studyListTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.prefetchDataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(StudyCell.self, forCellReuseIdentifier: StudyCell.cellId)
            $0.rowHeight = 105
        }
    }
    
    func layout() {
        [studyListTableView].forEach { view.addSubview($0) }

        studyListTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
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
        if searchResult.isEmpty {
            tableView.setEmptyView(type: .SearchStudyListEmptyViewType)
            return 0
        } else {
            tableView.restore()
        }
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudyCell.cellId, for: indexPath) as! StudyCell
        cell.setData(searchResult[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyValue = searchResult[indexPath.row].id
        presenter?.didTapCell(keyValue: keyValue, state: searchResult[indexPath.row].isMember!, studyTitle: searchResult[indexPath.row].title!)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
}

extension SearchStudyResultView: SearchStudyResultViewProtocol {    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
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
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.popViewController(animated: true)
        }
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
    }
}
