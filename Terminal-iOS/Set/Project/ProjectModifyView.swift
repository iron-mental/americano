//
//  ProjectModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/01.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class ProjectModifyView: UIViewController, CellSubclassDelegate {
    deinit { self.keyboardRemoveObserver() }
    
    var presenter: ProjectModifyPresenterProtocol?
    var projectArr: [Project] = []
    var isEditableViewTapping = false
    var currentScrollViewMinY: CGFloat = 0
    var currentScrollViewMaxY: CGFloat = 0
    var keyboardHeight: CGFloat = 0.0
    var standardContentHeight: CGFloat = 0.0
    
    var tappedView: UIView?
    var accessoryCompleteButton = UIButton()
    lazy var projectView = ProjectTableView()
    lazy var projectAddButton = UIButton()
    lazy var completeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        keyboardAddObserver(showSelector: #selector(keyboardWillShow),
                            hideSelector: #selector(keyboardWillHide))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.refreshEditableViewrange()
        self.view.becomeFirstResponder()
        self.standardContentHeight = self.projectView.contentSize.height
    }
    
    private func attribute() {
        self.do {
            $0.hideKeyboardWhenTappedAround()
            $0.view.backgroundColor = .appColor(.terminalBackground)
            $0.title = "프로젝트 수정"
        }
        
        self.projectView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
            $0.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.projectCellID)
            $0.estimatedRowHeight = 44
            $0.rowHeight = UITableView.automaticDimension
            $0.backgroundColor = .appColor(.terminalBackground)
        }
        
        self.projectAddButton.do {
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor
                = self.projectArr.count == 3
                ? .darkGray
                : .appColor(.mainColor)
            $0.setTitle(" + 프로젝트 추가", for: .normal)
            $0.titleLabel?.font = UIFont.notosansMedium(size: 16)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(addProject), for: .touchUpInside)
        }
        
        self.completeButton.do {
            $0.backgroundColor = .appColor(.mainColor)
            $0.setTitle("수정완료", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont.notosansMedium(size: 18)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
        
        self.accessoryCompleteButton.do {
            $0.setTitle("완료", for: .normal)
            $0.backgroundColor = .appColor(.mainColor)
            $0.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
    }
    
    private func layout() {
        self.view.addSubview(projectView)
        self.view.addSubview(projectAddButton)
        self.view.addSubview(completeButton)
        
        self.projectView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.projectAddButton.topAnchor, constant: -10).isActive = true
        }
        self.projectAddButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 130).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.completeButton.topAnchor, constant: -10).isActive = true
        }
        self.completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
    
    func getCellData() -> SNSValidate {
        var state: SNSValidate = SNSValidate(state: true, kind: "")
        
        for index in 0..<self.projectArr.count {
            let indexpath = IndexPath(row: index, section: 0)
            if let cell = projectView.cellForRow(at: indexpath) as? ProjectCell {
                let id = cell.projectID ?? nil
                let title = cell.title.text!
                let contents = cell.contents.text!
                let github = cell.sns.firstTextFeield.text ?? ""
                let appStore = cell.sns.secondTextField.text ?? ""
                let playStore = cell.sns.thirdTextField.text ?? ""
                
                //enum 으로 관리하면 더 명확할 듯
                if github.whitespaceCheck() || appStore.whitespaceCheck() || playStore.whitespaceCheck() {
                    state = SNSValidate(state: false, kind: "whitespace")
                } else if !appStore.appstoreCheck() {
                    state = SNSValidate(state: false, kind: "appstore")
                } else if !playStore.playstoreCheck() {
                    state = SNSValidate(state: false, kind: "playstore")
                }
                
                self.projectArr[index] = Project(id: id,
                                                 title: title,
                                                 contents: contents,
                                                 snsGithub: github,
                                                 snsAppstore: appStore,
                                                 snsPlaystore: playStore,
                                                 createAt: "")
            }
        }
        return state
    }
    
    func editableViewDidTap(textView: UIView, viewMinY: CGFloat, viewMaxY: CGFloat) {
        if let parentView = textView.superview {
            var targetMinY: CGFloat = 0
            var targetMaxY: CGFloat = 0
            
            if type(of: parentView) == ProjectSNSModifyView.self {
                //sns textField 클릭 시
                if let cellView = parentView.superview?.superview,
                   let superView = parentView.superview?.superview?.superview {
                    targetMinY = textView.frame.minY
                        + parentView.frame.minY
                        + cellView.frame.origin.y
                        + superView.frame.origin.y
                    
                    targetMaxY = textView.frame.maxY
                        + parentView.frame.minY
                        + cellView.frame.origin.y
                        + superView.frame.origin.y
                }
            } else {
                //제목 or 내용 textView 클릭 시
                if let cellView = parentView.superview,
                   let superView = parentView.superview?.superview {
                    targetMinY = textView.frame.minY
                        + cellView.frame.origin.y
                        + superView.frame.origin.y
                    
                    targetMaxY = textView.frame.maxY
                        + cellView.frame.origin.y
                        + superView.frame.origin.y
                }
            }
            if viewMinY >= targetMinY {
                let distance = targetMinY - viewMinY
                self.viewSetTop(distance: distance - self.accessoryCompleteButton.frame.height)
            } else if viewMaxY <= targetMaxY {
                let distance = targetMaxY - viewMaxY
                self.viewSetBottom(distance: distance + self.accessoryCompleteButton.frame.height)
            } else {
                self.isEditableViewTapping = false
            }
        }
    }
    
    func viewSetTop(distance: CGFloat) {
        self.completeButton.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.projectView.contentOffset.y += distance
        } completion: { _ in
            self.tappedView?.becomeFirstResponder()
            self.isEditableViewTapping = false
        }
    }
    
    func viewSetBottom(distance: CGFloat) {
        self.completeButton.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.projectView.contentSize.height += distance
            self.projectView.contentOffset.y += distance
        } completion: { _ in
            self.tappedView?.becomeFirstResponder()
            self.isEditableViewTapping = false
        }
    }
    
    func refreshEditableViewrange() {
        self.currentScrollViewMinY = self.projectView.contentOffset.y + self.projectView.frame.origin.y
        self.currentScrollViewMaxY = self.projectView.contentOffset.y + (UIScreen.main.bounds.height - keyboardHeight)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        keyboardHeight = keyboardRectangle.height
        isEditableViewTapping = false
    }
    
    @objc func keyboardWillHide() {
        self.projectView.transform = .identity
        self.completeButton.alpha = 1
        self.projectView.contentSize.height = standardContentHeight
    }
    
    @objc func completeModify() {
        let snsValidate = getCellData()
        if snsValidate.state {
            showLoading()
            presenter?.completeModify(project: self.projectArr)
        } else {
            if snsValidate.kind == "whitespace" {
                self.showToast(controller: self, message: "공백은 포함되지 않습니다.", seconds: 0.5)
            } else {
                self.showToast(controller: self, message: "SNS 형식이 맞지 않습니다.", seconds: 0.5)
            }
        }
        
    }
    
    @objc func addProject() {
        self.isEditableViewTapping = true
        self.projectAddButton.isUserInteractionEnabled = false
        
        if projectArr.count < 3 {
            let project = Project(id: nil,
                                  title: "",
                                  contents: "",
                                  snsGithub: "",
                                  snsAppstore: "",
                                  snsPlaystore: "",
                                  createAt: "")
            self.projectArr.append(project)
            if self.projectArr.count == 3 {
                self.projectAddButton.backgroundColor = .darkGray
            }
            self.projectView.insertRows(at: [IndexPath(row: projectArr.count - 1, section: 0)], with: .fade)
            if !projectArr.isEmpty {
                let index = IndexPath(row: projectArr.count - 1, section: 0)
                self.projectView.scrollToRow(at: index, at: .bottom, animated: true)
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
                if let cell = self.projectView.cellForRow(at: [0, self.projectArr.count - 1]) as? ProjectCell {
                    cell.title.becomeFirstResponder()
                    self.standardContentHeight += cell.frame.height
                }
                self.projectAddButton.isUserInteractionEnabled = true
            }
        } else {
            self.projectAddButton.isUserInteractionEnabled = true
            TerminalAlertMessage.show(controller: self, type: .ProjectLimitView)
        }
    }
}

extension ProjectModifyView: ProjectModifyViewProtocol {
    func modifyResultHandle(result: Bool, message: String) {
        if result {
            let parent = self.navigationController?.viewControllers[1] as? ProfileDetailView
            self.navigationController?.popViewController(animated: true) {
                parent?.showToast(controller: parent!, message: "프로젝트 수정 완료", seconds: 1)
                parent?.presenter?.viewDidLoad()
            }
        } else {
            hideLoading()
            self.showToast(controller: self, message: "다시 시도해 주세요.", seconds: 0.5)
        }
    }
    
    func showError(message: String, label: String) {
        
        // 서버에서 내려오는 label 자르기
        // ex) "project_list[0].title"
        let tempResult = label.components(separatedBy: ".")
        let index = tempResult[0].components(separatedBy: ["[", "]"])
        
        let row = Int(index[1])!
        let label = tempResult[1]
        let indexPath = IndexPath(row: row, section: 0)
        
        // cellForRow의 nil값 반환으로 인해 scroll 후 cell 반환하도록 함
        self.projectView.scrollToRow(at: indexPath, at: .top, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            if let cell = self.projectView.cellForRow(at: indexPath) as? ProjectCell {
                self.showToast(controller: self, message: message, seconds: 1) {
                    cell.setWarning(label: label)
                }
            }
        }
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
}

extension ProjectModifyView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectView.dequeueReusableCell(withIdentifier: ProjectCell.projectCellID, for: indexPath) as! ProjectCell
        
        cell.delegate = self
        cell.setDelegate(with: self)
        cell.setTag(tag: indexPath.row)
        cell.setAccessory(accessory: accessoryCompleteButton)
        
        let result = projectArr[indexPath.row]
        cell.setData(data: result)
        return cell
    }
    
    func buttonTapped(cell: ProjectCell) {
        guard let indexPath = self.projectView.indexPath(for: cell) else { return }
        if let cellHeight = projectView.cellForRow(at: [0, projectArr.count - 1])?.frame.height {
            standardContentHeight -= cellHeight
        }
        let index = indexPath.row
        self.projectArr.remove(at: index)
        self.projectView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        self.projectAddButton.backgroundColor
            = self.projectArr.count < 3
            ? .appColor(.mainColor)
            : .darkGray
        
        refreshEditableViewrange()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if type(of: scrollView) == ProjectTableView.self {
            refreshEditableViewrange()
            if !isEditableViewTapping {
                view.endEditing(true)
            }
        }
    }
}

extension ProjectModifyView: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        refreshEditableViewrange()
        isEditableViewTapping = true
        tappedView = textField
        self.editableViewDidTap(textView: tappedView!,
                                viewMinY: CGFloat(currentScrollViewMinY),
                                viewMaxY: CGFloat(currentScrollViewMaxY))
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 테이블뷰 재사용으로 인한 값 초기화를 방지하기 위해서
        let index = textField.tag
        let title = textField.text!
        self.projectArr[index].title = title
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        refreshEditableViewrange()
        isEditableViewTapping = true
        tappedView = textView
        self.editableViewDidTap(textView: tappedView!,
                                viewMinY: CGFloat(currentScrollViewMinY),
                                viewMaxY: CGFloat(currentScrollViewMaxY))
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // 테이블뷰 재사용으로 인한 값 초기화를 방지하기 위해서
        let index = textView.tag
        let contents = textView.text!
        self.projectArr[index].contents = contents
    }
}
