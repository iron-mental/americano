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
    let selectedUnderline = UIView()
    var presenter: StudyListPresenterProtocol?
    var studyList: [Study] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad()
    }
    
    func attribute() {
        view.backgroundColor = UIColor.appColor(.terminalBackground)
        aligmentView.backgroundColor = UIColor.appColor(.terminalBackground)
        
        lateButton.do {
            $0.setTitle("최신", for: .normal)
            $0.addTarget(self, action: #selector(late), for: .touchUpInside)
        }
        
        locationButton.do {
            $0.setTitle("지역", for: .normal)
            $0.addTarget(self, action: #selector(location), for: .touchUpInside)
        }
        
        selectedUnderline.do {
            $0.backgroundColor = .white
        }
        
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(StudyCell.self, forCellReuseIdentifier: StudyCell.cellId)
            $0.rowHeight = 105
        }
    }
    
    func layout() {
        view.addSubview(aligmentView)
        aligmentView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.29).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
        }
        aligmentView.addSubview(lateButton)
        aligmentView.addSubview(locationButton)
        aligmentView.addSubview(selectedUnderline)
        
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
        
        view.addSubview(tableView)
        tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: aligmentView.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    @objc func late() {
        print(self.selectedUnderline.center.x)
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
            self.selectedUnderline.center.x = self.lateButton.center.x
        }
        print(self.selectedUnderline.center.x)
    }
    
    @objc func location() {
        print(self.selectedUnderline.center.x)
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
            self.selectedUnderline.center.x = self.locationButton.center.x
        }
        print(self.selectedUnderline.center.x)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = StudyDetailViewController()
        view.state = .before
        self.present(view, animated: true)
    }
}
