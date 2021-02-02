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

enum MyStudyMainViewState {
    case normal
    case edit
}

// MARK: 마이스터디 탭에 들어갈 메인 뷰 입니다.
class MyStudyMainView: UIViewController {
    var applyState: Bool = false
    
    var presenter: MyStudyMainPresenterProtocol?
    var state: MyStudyMainViewState = .normal
    var moreButton: UIBarButtonItem?
    var tableView = UITableView()
    var alarmButton = BadgeBarButtonItem()
    var tempButton: UIBarButtonItem?
    var rightBarButtomItem: UIBarButtonItem?
    var dismissEditViewButtonItem: UIBarButtonItem?
    //alarmbutton 쇼잉을 위한 임시 변수!! 곧 삭제됩니다.
    var tempCountForBadge = 0
    var tempArrayForCheck: [Int] = []
    var editDoneButton: UIBarButtonItem?
    var myStudyList: [MyStudy] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyState ? presenter?.showApplyList(): nil
    }
    
    func attribute() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        moreButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(moreButtonAction(_ :)))
        moreButton?.do {
            $0.image = #imageLiteral(resourceName: "more")
            $0.tintColor = .white
        }
        
        self.do {
            $0.title = "내 스터디"
            $0.navigationController?.navigationBar.standardAppearance = appearance
            $0.navigationController?.navigationBar.barTintColor = UIColor.appColor(.terminalBackground)
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        tableView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.register(MyStudyMainTableViewCell.self, forCellReuseIdentifier: MyStudyMainTableViewCell.identifier)
            $0.separatorColor = myStudyList.isEmpty ? .clear : .none
            $0.delegate = self
            $0.dataSource = self
            $0.refreshControl = refreshControl
        }
        alarmButton.do {
            $0.button.addTarget(self, action: #selector(alarmButtonAction), for: .touchUpInside)
        }
        dismissEditViewButtonItem = UIBarButtonItem(title: "취소",
                                                    style: .done,
                                                    target: self,
                                                    action: #selector(dismissEditViewButtonItemAction))
        editDoneButton = UIBarButtonItem(title: "나가기",
                                         style: .done,
                                         target: self,
                                         action: #selector(editDoneButtonAction))
        refreshControl.do {
            $0.addTarget(self, action: #selector(viewDidLoad), for: .valueChanged)
        }
    }
    
    func layout() {
        switch state {
        case .edit:
            self.navigationItem.leftBarButtonItems = [dismissEditViewButtonItem!]
            self.navigationItem.rightBarButtonItems = [editDoneButton!]
        case .normal:
            self.navigationItem.rightBarButtonItems = [moreButton!, alarmButton]
        }
        
        self.view.addSubview(self.tableView)
        
        self.tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    @objc func moreButtonAction(_ sender: UIBarButtonItem) {
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let edit =  UIAlertAction(title: "스터디 편집", style: .default) { _ in self.editButtonAction() }
        let applyList =  UIAlertAction(title: "스터디 신청 목록", style: .default) {_ in self.applyList() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        [edit, applyList, cancel].forEach { alert.addAction($0) }
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func dismissEditViewButtonItemAction() {
        self.navigationItem.leftBarButtonItems?.removeAll()
        self.navigationItem.rightBarButtonItems?.removeAll()
        state = .normal
        layout()
        tempArrayForCheck.removeAll()
        tableView.reloadData()
    }
    
    @objc func editButtonAction() {
        self.navigationItem.rightBarButtonItems?.removeAll()
        state = .edit
        layout()
        tableView.reloadData()
    }
    
    @objc func applyList() {
        presenter?.showApplyList()
    }
    
    @objc func alarmButtonAction() {
        alarmButton.badgeLabel.isHidden = false
        tempCountForBadge += 1
        alarmButton.badgeLabel.text = "\(tempCountForBadge)"
        presenter?.showAlert()
    }
    
    @objc func editDoneButtonAction() {
        tempArrayForCheck.forEach { checkedID in
            myStudyList.remove(at: myStudyList.firstIndex(where: { $0.id == checkedID })!)
        }
        dismissEditViewButtonItemAction()
    }
}

extension MyStudyMainView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myStudyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyStudyMainTableViewCell.identifier) as! MyStudyMainTableViewCell
        
        switch state {
        case .normal:
            cell.checkBox.isHidden = true
            cell.notiGuideView.isHidden = false
        case .edit:
            cell.checkBox.isHidden = false
            cell.notiGuideView.isHidden = true
            if tempArrayForCheck.contains(myStudyList[indexPath.row].id) {
                cell.checkBox.backgroundColor = .appColor(.mainColor)
            } else {
                cell.checkBox.backgroundColor = .appColor(.testColor)
            }
        }
        
        cell.locationLabel.text = myStudyList[indexPath.row].sigungu
        cell.titleLabel.text = myStudyList[indexPath.row].title
        cell.locationLabel.widthAnchor.constraint(equalToConstant: cell.locationLabel.intrinsicContentSize.width + 10).isActive = true
        let token = KeychainWrapper.standard.string(forKey: "accessToken")!
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
        
        if myStudyList[indexPath.row].image == "" || myStudyList[indexPath.row].image == "test" {
            cell.studyMainimage.image = UIImage(named: "swiftmain")
        } else {
            let url = URL(string: myStudyList[indexPath.row].image!)
            cell.studyMainimage.kf.setImage(with: url, options: [.requestModifier(imageDownloadRequest)])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (91.7/667) * view.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch state {
        case .normal:
            presenter?.didClickedCellForDetail(view: self, selectedStudy: myStudyList[indexPath.row])
        case .edit:
            if tempArrayForCheck.contains(myStudyList[indexPath.row].id) {
                tempArrayForCheck.remove(at: tempArrayForCheck.firstIndex(of: myStudyList[indexPath.row].id)!)
            } else {
                tempArrayForCheck.append(myStudyList[indexPath.row].id)
            }
        }
        tableView.reloadData()
    }
}

extension MyStudyMainView: MyStudyMainViewProtocol {
    func showLoading() {
        LoadingRainbowCat.show()
    }
    
    func showMyStudyList(myStudyList: [MyStudy]) {
        myStudyList.forEach {
            print($0.id)
        }
        self.myStudyList = myStudyList
        attribute()
        layout()
        tableView.reloadData()
        LoadingRainbowCat.hide {
            print("로딩 끝")
        }
        self.refreshControl.endRefreshing()
    }
    
    func showErrMessage() {
        LoadingRainbowCat.hide {
            print("에러 떴습니다~")
        }
    }
}
