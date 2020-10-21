//
//  MyStudyMainView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyMainView: UIViewController {
    var presenter: MyStudyMainPresenterProtocol?
    
    var moreButton: UIBarButtonItem?
    var tableView = UITableView()
    var alarmButton: UIBarButtonItem?
    var tempButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        moreButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(moreButtonAction(_ :)))
        moreButton?.do {
            //추후에 more버튼으로 교체
            $0.image = #imageLiteral(resourceName: "more")
            $0.tintColor = .white
        }
        alarmButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(alarmButtonAction(_ :)))
        alarmButton?.do {
            $0.image = #imageLiteral(resourceName: "alarm")
            $0.tintColor = .white
        }
        tempButton = UIBarButtonItem(title: "임시버튼", style: .done, target: self, action: #selector(goToLoginAction(_ :)))
        self.do {
            $0.title = "내 스터디"
            $0.navigationItem.rightBarButtonItems = [moreButton!, alarmButton!,tempButton!]
            $0.navigationController?.navigationBar.backgroundColor = UIColor.appColor(.testColor)
            $0.navigationController?.navigationBar.prefersLargeTitles = true
        }
        tableView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.register(MyStudyMainTableViewCell.self, forCellReuseIdentifier: MyStudyMainTableViewCell.identifier)
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func layout() {
        view.addSubview(tableView)
        
        tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    @objc func moreButtonAction(_ sender: UIBarButtonItem) {
        let alert =  UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let edit =  UIAlertAction(title: "스터디 편집", style: .default) {_ in }
        let temp =  UIAlertAction(title: "여긴뭐들어갑니까", style: .default) {_ in }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        [edit,temp,cancel].forEach {
            alert.addAction($0)
        }
        
        present(alert, animated: true, completion: nil)
    }
    @objc func alarmButtonAction(_ sender: UIBarButtonItem) {
        print("clicked more Button!!")
    }
    @objc func goToLoginAction(_ sender: UIBarButtonItem) {
        let view = LoginView()
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true)
    }
}

extension MyStudyMainView: MyStudyMainViewProtocol {
    
}

extension MyStudyMainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyStudyMainTableViewCell.identifier) as! MyStudyMainTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (91.7/667) * view.bounds.height
    }
}
