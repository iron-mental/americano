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

// MARK: 마이스터디 탭에 들어갈 메인 뷰 입니다.
class MyStudyMainView: UIViewController {
    var applyState: Bool = false
    
    var presenter: MyStudyMainPresenterProtocol?
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
        refreshControl.do {
            $0.addTarget(self, action: #selector(viewDidLoad), for: .valueChanged)
        }
    }
    
    func layout() {
        self.navigationItem.rightBarButtonItems = [moreButton!, alarmButton]
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
        let applyList =  UIAlertAction(title: "스터디 신청 목록", style: .default) {_ in self.applyList() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        [ applyList, cancel].forEach { alert.addAction($0) }
        self.present(alert, animated: true, completion: nil)
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
}

extension MyStudyMainView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myStudyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyStudyMainTableViewCell.identifier) as! MyStudyMainTableViewCell

            cell.checkBox.isHidden = true
            cell.notiGuideView.isHidden = false

        
        cell.locationLabel.text = myStudyList[indexPath.row].sigungu
        cell.titleLabel.text = myStudyList[indexPath.row].title
        cell.locationLabel.widthAnchor.constraint(equalToConstant: cell.locationLabel.intrinsicContentSize.width + 30).isActive = true
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
        presenter?.didClickedCellForDetail(view: self, selectedStudy: myStudyList[indexPath.row])
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
