//
//  NotificationView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NotificationView: UIViewController {
    var presenter: NotificationPresenterProtocol?
    let tableView = UITableView()
    var notiList: [Noti] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad()
    }
    
    func attribute() {
        self.do {
            $0.title = "알림"
        }
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.cellID)
            $0.rowHeight = Terminal.convertHeight(value: 80)
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.separatorColor = notiList.isEmpty ? .clear : .none
        }
    }
    
    func layout() {
        view.addSubview(tableView)
        tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
}

extension NotificationView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.cellID, for: indexPath) as! NotificationCell
        let data = notiList[indexPath.row]
        cell.setData(noti: data)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
    }
}

extension NotificationView: NotificationViewProtocol {
    func showNotiList(notiList: [Noti]) {
        self.notiList = notiList
        self.tableView.reloadData()
    }
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
    
    func showLoading() {
        LoadingRainbowCat.show()
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide()
    }
}
