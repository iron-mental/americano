//
//  ProjectModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/01.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ProjectModifyView: UIViewController, CellSubclassDelegate {
    var presenter: ProjectModifyPresenterProtocol?
    var projectArr: [Project] = []
    var index: IndexPath?
    
    lazy var projectView = ProjectTableView()
    lazy var projectAddButton = UIButton()
    lazy var completeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        keyboardAddObserver(with: self,
                            showSelector: nil,
                            hideSelector: #selector(keyboardWillHide))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.keyboardRemoveObserver(with: self)
    }
    
    
//    이해끝
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
            if projectArr.count == 3 {
                $0.backgroundColor = .darkGray
            } else {
                $0.backgroundColor = UIColor.appColor(.mainColor)
            }
            $0.setTitle(" + 프로젝트 추가", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(addProject), for: .touchUpInside)
        }
        
        self.completeButton.do {
            $0.backgroundColor = .appColor(.mainColor)
            $0.setTitle("수정완료", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
    }
    
//    이해끝
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
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
    
    func getCellData() -> SNSValidate {
        // 공백여부 체크 변수
        var state: SNSValidate = SNSValidate(state: true, kind: "")
        
        for index in 0..<projectArr.count {
            let indexpath = IndexPath(row: index, section: 0)
            let cell = projectView.cellForRow(at: indexpath) as! ProjectCell
            
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
            
            projectArr[index] = Project(id: id,
                                        title: title,
                                        contents: contents,
                                        snsGithub: github,
                                        snsAppstore: appStore,
                                        snsPlaystore: playStore,
                                        createAt: "")
        }
        return state
    }
    
    @objc func keyboardWillHide() {
        self.projectView.transform = .identity
    }
    
    @objc func completeModify() {
        let snsValidate = getCellData()
        // 공백체크
        if snsValidate.state {
            LoadingRainbowCat.show()
            presenter?.completeModify(project: projectArr)
        } else {
            if snsValidate.kind == "whitespace" {
                self.showToast(controller: self, message: "공백은 포함되지 않습니다.", seconds: 0.5)
            } else {
                self.showToast(controller: self, message: "SNS 형식이 맞지 않습니다.", seconds: 0.5)
            }
        }
    }
    
    @objc func addProject() {
        if projectArr.count < 3 {
            let project = Project(id: nil, title: "", contents: "", snsGithub: "", snsAppstore: "", snsPlaystore: "", createAt: "")
            projectArr.append(project)
            projectView.insertRows(at: [IndexPath(row: projectArr.count - 1, section: 0)], with: .right)
            
            if projectArr.count == 3 {
                projectAddButton.backgroundColor = .darkGray
            }
            
            if !projectArr.isEmpty {
                let index = IndexPath(row: projectArr.count - 1, section: 0)
                self.projectView.scrollToRow(at: index, at: .bottom, animated: true)
            }
        } else {
//            let alert = UIAlertController(title: "알림",
//                                          message: "프로젝트는 최대 3개입니다.",
//                                          preferredStyle: UIAlertController.Style.alert)
//            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil )
            
//            alert.addAction(okAction)
//            present(alert, animated: true)
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
            // 실패시 에러처리 부분
            LoadingRainbowCat.hide()
            self.showToast(controller: self, message: "다시 시도해 주세요.", seconds: 0.5)
        }
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
        
        let result = projectArr[indexPath.row]
        cell.setData(data: result)
        
        return cell
    }
    
    func buttonTapped(cell: ProjectCell) {
        guard let indexPath = self.projectView.indexPath(for: cell) else {
            return
        }
        let index = indexPath.row
        
        self.projectArr.remove(at: index)
        self.projectView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        self.projectAddButton.backgroundColor =
            self.projectArr.count < 3 ? UIColor.appColor(.mainColor) : UIColor.darkGray
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension ProjectModifyView: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let index = IndexPath(row: textField.tag, section: 0)
        if textField.tag != 0 {
            self.projectView.transform = CGAffineTransform(translationX: 0, y: -170)
            self.projectView.scrollToRow(at: index, at: .top, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let index = IndexPath(row: textView.tag, section: 0)
        if textView.tag != 0 {
            self.projectView.transform = CGAffineTransform(translationX: 0, y: -170)
            self.projectView.scrollToRow(at: index, at: .top, animated: true)
        }
    }
}
