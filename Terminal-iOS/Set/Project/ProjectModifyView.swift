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
    var projectArr: [Project] = [Project(id: 1, title: "dfdfd", contents: "fdfd", snsGithub: "fdfd", snsAppstore: "fdfdd", snsPlaystore: "f", createAt: "fd"),
                                 Project(id: 1, title: "dfdfd", contents: "fdfd", snsGithub: "fdfd", snsAppstore: "fdfdd", snsPlaystore: "f", createAt: "fd"),Project(id: 1, title: "dfdfd", contents: "fdfd", snsGithub: "fdfd", snsAppstore: "fdfdd", snsPlaystore: "f", createAt: "fd"),Project(id: 1, title: "dfdfd", contents: "fdfd", snsGithub: "fdfd", snsAppstore: "fdfdd", snsPlaystore: "f", createAt: "fd")]
    let projectView = ProjectTableView()
    let projectAddButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        self.view.backgroundColor = .black
        
        self.projectView.do {
//            $0.isScrollEnabled = false
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
            $0.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.projectCellID)
            $0.estimatedRowHeight = 44
            $0.rowHeight = UITableView.automaticDimension
        }
        
        self.projectAddButton.do {
            $0.setTitleColor(.white, for: .normal)
            if projectArr.count == 3 {
                $0.backgroundColor = .darkGray
            } else {
                $0.backgroundColor = UIColor.appColor(.mainColor)
            }
            $0.setTitle(" + 프로젝트 추가", for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(addProject), for: .touchUpInside)
        }
    }
    
    private func layout() {
        self.view.addSubview(projectView)
        self.view.addSubview(projectAddButton)
        
        self.projectView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(lessThanOrEqualToConstant: 650).isActive = true
        }
        self.projectAddButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.projectView.bottomAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 130).isActive = true
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
        } else {
            let alert = UIAlertController(title: "알림",
                                          message: "프로젝트는 최대 3개입니다.",
                                          preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler : nil )

            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
}

extension ProjectModifyView: ProjectModifyViewProtocol {
    func modifyResultHandle(result: Bool, message: String) {
        
    }
}

extension ProjectModifyView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectView.dequeueReusableCell(withIdentifier: ProjectCell.projectCellID, for: indexPath) as! ProjectCell
        cell.selectionStyle = .none
        cell.delegate = self
        
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
        self.projectView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .none)
        self.projectAddButton.backgroundColor =
            self.projectArr.count < 3 ? UIColor.appColor(.mainColor) : UIColor.darkGray
    }
}
