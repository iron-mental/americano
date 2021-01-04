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
    var keyWord: String?
    var studyListTableView = UITableView()
    var searchResult: [Study] = []
    let backBtn = UIButton()
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.returnDidTap(keyWord: keyWord!)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        studyListTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(StudyCell.self, forCellReuseIdentifier: StudyCell.cellId)
            $0.rowHeight = 105
        }
        backBtn.do {
            $0.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
            $0.addTarget(self, action: #selector(back), for: .touchUpInside)
        }
        searchBar.do {
            $0.placeholder = "스터디명, 분류(키워드) 등"
            $0.barTintColor = UIColor.appColor(.terminalBackground)
            $0.delegate = self
            $0.text = keyWord
        }
    }
    
    func layout() {
        [studyListTableView, backBtn, searchBar].forEach { view.addSubview($0) }
        
        backBtn.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
            ])
        }
        searchBar.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
                $0.leadingAnchor.constraint(equalTo: self.backBtn.trailingAnchor, constant: 10),
                $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                $0.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
        studyListTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate ([
                $0.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchStudyResultView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: StudyCell.cellId, for: indexPath) as! StudyCell
        cell.setData(searchResult[indexPath.row])
        return cell
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
    }
}
