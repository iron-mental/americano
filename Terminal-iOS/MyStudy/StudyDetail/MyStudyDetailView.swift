//
//  StudyDetailView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

enum MyStudyDetialInitView {
    case Notice
    case StudyDetial
    case Chat
}

class MyStudyDetailView: UIViewController {
    var presenter: MyStudyDetailPresenterProtocol?
    
    var viewState: MyStudyDetialInitView = .StudyDetial
    let appearance = UINavigationBarAppearance()
    var applyState: Bool = false
    var alertID: Int?
    var studyID: Int? { didSet { setPageControllerChild() } }
    var studyTitle: String?
    var pageBeforeIndex: Int = 0
//    var tabBeforeIndex: Int = 0
    var VCArr: [UIViewController] = []
    let state: [String] = ["공지사항", "스터디 정보", "채팅"]
    var studyInfo: StudyDetail?
    var userList: [Participate] = []
    var authority: StudyDetailViewState = .member
    
    lazy var tapSege = UISegmentedControl(items: state)
    lazy var selectedUnderLine = UIView()
    lazy var moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "more"),
                                          style: .done,
                                          target: self,
                                          action: #selector(moreButtonDidTap))
    let childPageView = UIPageViewController(transitionStyle: .scroll,
                                             navigationOrientation: .horizontal,
                                             options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyState ? presenter?.showApplyUserList(studyID: studyID!) : nil
        applyState = false
    }
    
    func attribute() {
        self.do {
            //레거시임 청산해야할 부분
            if let title = studyInfo?.title {
                $0.title = title
            } else {
                $0.title = studyTitle
            }
            view.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        
        self.appearance.do {
            $0.configureWithTransparentBackground()
        }
        
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.navigationController?.navigationBar.standardAppearance = appearance
            $0.navigationItem.rightBarButtonItems = [moreButton]
        }
        
        self.tapSege.do {
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14),
                                       .foregroundColor: UIColor.gray],
                                      for: .normal)
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16),
                                       .foregroundColor: UIColor.white],
                                      for: .selected)
            $0.selectedSegmentIndex = 0
            $0.layer.cornerRadius = 0
            $0.backgroundColor = .clear
            $0.tintColor = UIColor.appColor(.terminalBackground)
            $0.clearBG()
            $0.selectedSegmentTintColor = .clear
            $0.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        }

        self.selectedUnderLine.do {
            $0.backgroundColor = .white
        }
        
        self.childPageView.do {
            $0.delegate = self
            $0.dataSource = self
        }
        switch viewState {
        case .Notice:
            self.tapSege.selectedSegmentIndex = 0
            self.childPageView.setViewControllers([self.VCArr[0]], direction: .forward, animated: true, completion: nil)
            self.pageBeforeIndex = 0
        case .StudyDetial:
            self.tapSege.selectedSegmentIndex = 1
            self.childPageView.setViewControllers([self.VCArr[1]], direction: .forward, animated: true, completion: nil)
            self.selectedUnderLine.transform = CGAffineTransform(translationX: self.view.frame.width / 3 * CGFloat(1), y: 0)
            self.pageBeforeIndex = 1
        case .Chat:
            break
        }
    }
    
    func layout() {
        [tapSege, selectedUnderLine, childPageView.view]
            .forEach { view.addSubview($0) }
        self.addChild(childPageView)
        self.childPageView.didMove(toParent: self)
        
        self.tapSege.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 38)).isActive = true
        }
        
        self.selectedUnderLine.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: tapSege.bottomAnchor, constant: -1).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
            $0.widthAnchor.constraint(equalToConstant: view.frame.width / 3).isActive = true
        }
        
        self.childPageView.view.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: tapSege.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    func addNoticeButtonDidTap() {
        presenter?.addNoticeButtonDidTap(studyID: studyID!, parentView: self)
    }
    
    func editStudyButtonDidTap() {
        if let targetStudy = (VCArr[1] as! StudyDetailView).studyInfo {
            presenter?.editStudyButtonDidTap(study: targetStudy, parentView: self)
        }
    }
    
    func applyListButtonDidTap() {
        presenter?.showApplyUserList(studyID: studyID!)
    }
    
    func delegateHostButtonDidTap() {
        guard let userList = studyInfo?.participate else { return }
        presenter?.delegateHostButtonDidTap(studyID: studyID!, userList: userList)
        //방장 위임하는 뷰로 가보자
    }
    
    func deleteStudyButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .DeleteStudyView)
        TerminalAlertMessage.getAlertCompleteButton().addTarget(self, action: #selector(deleteStudyCompleteButtonDidTap), for: .touchUpInside)
    }
    
    func leaveStudyButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .LeaveStudyView)
        TerminalAlertMessage.getAlertCompleteButton().addTarget(self, action: #selector(leaveStudyCompleteButtonDidTap), for: .touchUpInside)
    }
    
    func setPageControllerChild() {
        VCArr =  [ NoticeWireFrame.createNoticeModule(studyID: studyID!, parentView: self),
                   StudyDetailWireFrame.createStudyDetail(parent: self,
                                                          studyID: studyID!,
                                                          state: .member,
                                                          studyTitle: studyTitle ?? "",
                                                          alertID: alertID ?? nil),
                   ChatWireFrame.createChatModule()]
    }
    
    // MARK: - @objc
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        switch selectedIndex {
        case 0: viewState = .Notice
        case 1: viewState = .StudyDetial
        case 2: viewState = .Chat
        default: print("들어오지 않아요")
        }
        
        UIView.animate(withDuration: 0.2) {
            self.selectedUnderLine.transform = CGAffineTransform(translationX: self.view.frame.width / 3 * CGFloat(selectedIndex), y: 0)
        }
        
        // PageView paging
        let currentView = VCArr
        let nextPage = selectedIndex
        
        // if 현재페이지 < 바뀔페이지
        // else if 현재페이지 > 바뀔페이지
        if pageBeforeIndex < nextPage {
            let nextVC = currentView[nextPage]
            self.childPageView.setViewControllers([nextVC], direction: .forward, animated: true)
        } else if pageBeforeIndex > nextPage {
            let prevVC = currentView[nextPage]
            self.childPageView.setViewControllers([prevVC], direction: .reverse, animated: true)
        }
        pageBeforeIndex = nextPage
    }
    
    @objc func moreButtonDidTap() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let noticeAdd = UIAlertAction(title: "공지사항 추가", style: .default) { _ in self.addNoticeButtonDidTap() }
        let studyEdit = UIAlertAction(title: "스터디 정보 수정", style: .default) { _ in self.editStudyButtonDidTap() }
        let applyList = UIAlertAction(title: "스터디 신청 목록", style: .default) { _ in self.applyListButtonDidTap() }
        let delegateHost = UIAlertAction(title: "방장 위임하기", style: .default) { _ in self.delegateHostButtonDidTap() }
        let deleteStudy = UIAlertAction(title: "스터디 삭제하기", style: .destructive) { _ in self.deleteStudyButtonDidTap() }
        let leaveStudy = UIAlertAction(title: "스터디 나가기", style: .destructive) { _ in self.leaveStudyButtonDidTap() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        if authority == .host {
            [ noticeAdd, studyEdit, applyList, delegateHost, deleteStudy, leaveStudy, cancel ].forEach { alert.addAction($0) }
        } else if authority == .member {
            [ leaveStudy, cancel ].forEach { alert.addAction($0) }
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func leaveStudyCompleteButtonDidTap() {
        LoadingRainbowCat.show()
        presenter?.leaveStudyButtonDidTap(studyID: studyID!)
        TerminalAlertMessage.dismiss()
    }
    
    @objc func deleteStudyCompleteButtonDidTap() {
        LoadingRainbowCat.show()
        presenter?.deleteStudyButtonDidTap(studyID: studyID!)
        TerminalAlertMessage.dismiss()
    }
}

extension MyStudyDetailView: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = VCArr.firstIndex(of: viewController), index > 0 else { return nil }
        let previousIndex = index - 1
        return VCArr[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = VCArr.firstIndex(of: viewController),
              index < (VCArr.count - 1) else { return nil }
        let nextIndex = index + 1
        return VCArr[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.VCArr.firstIndex(of: viewControllers[0]) {
                self.tapSege.selectedSegmentIndex = viewControllerIndex
                UIView.animate(withDuration: 0.2) {
                    self.selectedUnderLine.transform =
                        CGAffineTransform(translationX: self.view.frame.width / 3 * CGFloat(viewControllerIndex), y: 0)
                }
            }
        }
    }
}

extension MyStudyDetailView: MyStudyDetailViewProtocol {
    func setting() {
        if let studyDetailView = VCArr[1] as? StudyDetailViewProtocol {
            studyInfo = studyDetailView.studyInfo
            authority = studyDetailView.state
            if let noticeView = VCArr[0] as? NoticeView {
                noticeView.state = studyDetailView.state
            }
        }
        attribute()
        layout()
        view.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            if !self.applyState {
                LoadingRainbowCat.hide()
            }
        })
    }
    
    func showLeaveStudyComplete(message: String) {
        LoadingRainbowCat.hide()
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.popViewController(animated: true)
            if let view = self.navigationController?.viewControllers[0] as? MyStudyMainViewProtocol {
                view.presenter?.viewDidLoad()
            }
        }
    }
    
    func showLeaveStudyFailed(message: String) {
        LoadingRainbowCat.hide()
        showToast(controller: self, message: message, seconds: 1, completion: nil)
    }
    
    func showDeleteStudyComplete(message: String) {
        LoadingRainbowCat.hide()
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.popViewController(animated: true)
            if let view = self.navigationController?.viewControllers[0] as? MyStudyMainViewProtocol {
                view.presenter?.viewDidLoad()
            }
        }
    }
    
    func showDeleteStudyFailed(message: String) {
        LoadingRainbowCat.hide()
        showToast(controller: self, message: message, seconds: 1)
    }
}
