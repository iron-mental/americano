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
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.returnDidTap(keyWord: keyword!)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        self.searchController.do {
            $0.searchResultsUpdater = self
            $0.obscuresBackgroundDuringPresentation = false
            $0.searchBar.showsCancelButton = false
            $0.hidesNavigationBarDuringPresentation = false
            $0.searchBar.text = keyword
            navigationItem.titleView = searchController.searchBar
            $0.searchBar.delegate = self
        }
        self.studyListTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(StudyCell.self, forCellReuseIdentifier: StudyCell.cellId)
            $0.rowHeight = 105
        }
    }
    
    func layout() {
        [studyListTableView ].forEach { view.addSubview($0) }

        studyListTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: false)
    }
}

extension SearchStudyResultView: UITableViewDelegate, UITableViewDataSource {
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
        //후에 서버에서 member처리해주면 그때 대응
//        guard let state = searchResult[indexPath.row].isMember else { return }
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
    
    func showSearchStudyResult(result: [Study]) {
        
        searchResult = result
        studyListTableView.reloadData()
    }
}

extension SearchStudyResultView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.returnDidTap(keyWord: searchBar.text!)
        view.endEditing(true)
    }
}

extension SearchStudyResultView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        <#code#>
    }
}
