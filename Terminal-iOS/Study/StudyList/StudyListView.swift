//
//  StudyListViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class StudyListView: UIViewController {
    var category: String?
    var sort: String?
    let tableView = UITableView()
    let aligmentView = UIView()
    let lateButton = UIButton()
    let locationButton = UIButton()
    let selectedUnderline = UIView()
    let refreshControl = UIRefreshControl()

    var sortState: SortState = .new
    
    var presenter: StudyListPresenterProtocol?
    var studyList: [Study] = []
    var lengthStudyList: [Study] = []
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.studyList(category: category!)
    }
    
    // MARK: Attribute
    
    func attribute() {
        view.backgroundColor = UIColor.appColor(.terminalBackground)
        aligmentView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        
        refreshControl.do {
            $0.addTarget(self, action: #selector(updateList), for: .valueChanged)
        }
        
        lateButton.do {
            $0.setTitle("최신", for: .normal)
            $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 17)
            $0.addTarget(self, action: #selector(new), for: .touchUpInside)
        }
        
        locationButton.do {
            $0.setTitle("지역", for: .normal)
            $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 17)
            $0.addTarget(self, action: #selector(length), for: .touchUpInside)
        }
        
        selectedUnderline.do {
            $0.backgroundColor = .white
        }
        
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.prefetchDataSource = self
            $0.register(StudyCell.self, forCellReuseIdentifier: StudyCell.cellId)
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.rowHeight = 105
            $0.refreshControl = refreshControl
        }
    }
    
    // MARK: Layout
    
    func layout() {
        view.addSubview(aligmentView)
        aligmentView.addSubview(lateButton)
        aligmentView.addSubview(locationButton)
        aligmentView.addSubview(selectedUnderline)
        view.addSubview(tableView)
        
        aligmentView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.29).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
        }
        lateButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: aligmentView.leadingAnchor, constant: 20).isActive = true
            $0.centerYAnchor.constraint(equalTo: aligmentView.centerYAnchor).isActive = true
        }
        locationButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: lateButton.trailingAnchor, constant: 20).isActive = true
            $0.centerYAnchor.constraint(equalTo: aligmentView.centerYAnchor).isActive = true
        }
        selectedUnderline.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: lateButton.bottomAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: lateButton.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 35).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
        }
        tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: aligmentView.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    
    @objc func updateList() {
        studyList.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.presenter?.studyList(category: self.category!)
            self.refreshControl.endRefreshing()
        }
        self.tableView.reloadData()
    }
    
    @objc func new() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
            self.selectedUnderline.center.x = self.lateButton.center.x
        }
        sortState = .new
    }
    
    @objc func length() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
            self.selectedUnderline.center.x = self.locationButton.center.x
        }
        sortState = .length
    }
}

extension StudyListView: StudyListViewProtocol {
    
    func showStudyList(with studies: [Study]) {
        for study in studies {
            studyList.append(study)
        }
        if sortState == .new {
            tableView.reloadData()
        }
    }
    
    func saveLengthStudyList(with studies: [Study]) {
        for study in studies {
            lengthStudyList.append(study)
        }
        if sortState == .length {
            tableView.reloadData()
        }
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
}

extension StudyListView: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    /// 페이징 첫번째 방법 이게 제일 효율 높음
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if studyList.count-1 == indexPath.row {
                presenter?.pagingStudyList()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudyCell.cellId, for: indexPath) as! StudyCell
        
        let study = studyList[indexPath.row]
        cell.setData(study)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyValue = studyList[indexPath.row].id
        presenter?.showStudyDetail(keyValue: keyValue)
    }
}

/// 2번째 방법
//extension StudyListView: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let height: CGFloat = scrollView.frame.size.height
//        let contentYOffset: CGFloat = scrollView.contentOffset.y
//        let scrollViewHeight: CGFloat = scrollView.contentSize.height
//        let distanceFromBottom: CGFloat = scrollViewHeight - contentYOffset
//
//        if distanceFromBottom < height {
//            presenter?.pagingStudyList()
//            tableView.reloadData()
//        }
//    }
//}
