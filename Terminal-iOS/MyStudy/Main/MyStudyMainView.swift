//
//  MyStudyMainView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftKeychainWrapper
import FirebaseCrashlytics

// MARK: 마이스터디 탭에 들어갈 메인 뷰 입니다.
final class MyStudyMainView: UIViewController {
    // state
    var presenter: MyStudyMainPresenterProtocol?
    var myStudyList: [MyStudy] = []
    var startedByPushNotification: Bool?
  
  
    // UI
    var alarmButton = BadgeBarButtonItem()
    let refreshControl = UIRefreshControl()
    let appearance = UINavigationBarAppearance()
    var tableView = UITableView()
    lazy var moreButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .appColor(.terminalBackground)
        navigationController?
            .navigationBar
            .standardAppearance
            .backgroundColor = .appColor(.terminalBackground)
    }
    
    func attribute() {
        self.do {
            $0.title = "내 스터디"
            $0.navigationController?.navigationBar.barTintColor = .appColor(.terminalBackground)
            $0.navigationItem.largeTitleDisplayMode = .automatic
            $0.view.backgroundColor = .appColor(.terminalBackground)
            $0.navigationController?.navigationBar.standardAppearance = appearance
        }
        self.navigationItem.do {
            $0.rightBarButtonItems = [moreButton, alarmButton]
        }
        tableView.do {
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.register(MyStudyMainTableViewCell.self, forCellReuseIdentifier: MyStudyMainTableViewCell.identifier)
            $0.separatorColor = myStudyList.isEmpty ? .clear : .none
            $0.delegate = self
            $0.dataSource = self
            $0.refreshControl = refreshControl
            $0.separatorColor = .clear
        }
        alarmButton.do {
            $0.button.addTarget(self, action: #selector(alarmButtonAction), for: .touchUpInside)
            guard let badge = $0.badgeLabel.text else { return }
            $0.badgeLabel.isHidden = Int(badge) == 0 ? true : false
        }
        moreButton.do {
            $0.image = UIImage(systemName: "ellipsis")?.withConfiguration(UIImage.SymbolConfiguration(weight: .regular))
            $0.target = self
            $0.action = #selector(moreButtonAction(_:))
        }
        refreshControl.do {
            $0.addTarget(self, action: #selector(updateList), for: .valueChanged)
        }
    }
    
    func layout() {
        self.view.addSubview(self.tableView)
        
        self.tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    // MARK: - @objc
    
    @objc func updateList() {
        presenter?.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func moreButtonAction(_ sender: UIBarButtonItem) {
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let applyList =  UIAlertAction(title: "내가 신청한 스터디", style: .default) {_ in self.applyList() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        [ applyList, cancel].forEach { alert.addAction($0) }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            self.present(alert, animated: true)
        }
    }
    
    @objc func applyList() {
        presenter?.showApplyList()
    }
    
    @objc func alarmButtonAction() {
        presenter?.showAlert()
    }
}

extension MyStudyMainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myStudyList.isEmpty {
            tableView.setEmptyView(type: .MyStudyListEmptyViewType)
            return 0
        } else {
            tableView.restore()
            return myStudyList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyStudyMainTableViewCell.identifier) as! MyStudyMainTableViewCell
        cell.setData(study: myStudyList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (91.7/667) * view.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didClickedCellForDetail(view: self, selectedStudy: myStudyList[indexPath.row])
        tableView.reloadData()
    }
}

extension MyStudyMainView: MyStudyMainViewProtocol {
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func showMyStudyList(myStudyList: MyStudyList) {
        if let studyList = myStudyList.studyList {
            self.myStudyList = studyList
        }
        if let badge = myStudyList.badge {
            self.alarmButton.badgeLabel.text = String(badge.alert)
            UIApplication.shared.applicationIconBadgeNumber = badge.total
        }
        attribute()
        layout()
        tableView.reloadData()
        if startedByPushNotification != nil && startedByPushNotification == true {
            presenter?.showStudyDetailDirectly()
            startedByPushNotification = nil
        }
        LoadingRainbowCat.hide(caller: self)
    }
    
    func showErrMessage(message: String) {
        LoadingRainbowCat.hide(caller: self)
        showToast(controller: self, message: message, seconds: 1)
    }
}
