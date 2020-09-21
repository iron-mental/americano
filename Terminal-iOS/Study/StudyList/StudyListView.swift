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
    
    let tableView = UITableView()
    let aligmentView = UIView()
    let lateButton = UIButton()
    let locationButton = UIButton()
    var presenter: StudyListPresenterProtocol?
    var studyList: [Study] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad()
    }
    
    func attribute() {
//        aligmentView.backgroundColor = UIColor.appColor(.terminalBackground)
        aligmentView.backgroundColor = UIColor(named: "background")
        
        lateButton.do {
            $0.setTitle("최신", for: .normal)
        }
        
        locationButton.do {
            $0.setTitle("지역", for: .normal)
        }
        
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
//            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.backgroundColor = UIColor(named: "background")
            $0.register(StudyCell.self, forCellReuseIdentifier: StudyCell.cellId)
            $0.rowHeight = 100
        }
    }
    
    func layout() {
        view.addSubview(aligmentView)
        aligmentView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 55).isActive = true
        }
        aligmentView.addSubview(lateButton)
        aligmentView.addSubview(locationButton)
        
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
        
        view.addSubview(tableView)
        tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: aligmentView.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
}

extension StudyListView: StudyListViewProtocol {
    
    func showStudyList(with studies: [Study]) {
        studyList = studies
        tableView.reloadData()
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
}

extension StudyListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudyCell.cellId, for: indexPath) as! StudyCell
        
        let study = studyList[indexPath.row]
        cell.setData(study)
                
        return cell
    }
}
