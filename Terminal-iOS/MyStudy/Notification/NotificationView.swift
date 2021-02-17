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
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
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
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
}

extension NotificationView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notiList.isEmpty {
            tableView.setEmptyView(type: .NotiListEmptyViewType)
            return 0
        } else {
            tableView.restore()
            return notiList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.cellID, for: indexPath) as! NotificationCell
        let data = notiList[indexPath.row]
        cell.setData(noti: data)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.cellDidTap(alert: notiList[indexPath.row])
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
    
    func showAlert(message: String) {
        //toast가 아닌 alert으로 해아할지 고민
        showToast(controller: self, message: message, seconds: 1)
    }
    
    func showLoading() {
        LoadingRainbowCat.show()
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide()
    }
}
