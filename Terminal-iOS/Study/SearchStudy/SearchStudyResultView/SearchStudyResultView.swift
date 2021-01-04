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
    }
    
    func layout() {
        [studyListTableView].forEach { view.addSubview($0) }
        
        studyListTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate ([
                $0.topAnchor.constraint(equalTo: view.topAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
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
