//
//  StudyDetailView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MyStudyDetailView: UIViewController {
    var presenter: MyStudyDetailPresenterProtocol?
    var noticePushEvent: Bool = false
    var getPushEvent: Bool = false
    var applyState: Bool = false
    var studyID: Int? {
        didSet {
            VCArr =  [ NoticeWireFrame.createNoticeModule(studyID: studyID!),
                       StudyDetailWireFrame.createStudyDetail(parent: self, studyID: studyID!, state: .member, studyTitle: studyTitle ?? ""),
                       ChatWireFrame.createChatModule()]
        }
    }
    var studyTitle: String?
    var studyInfo: StudyDetail?
    var userList: [Participate] = []
    var pageBeforeIndex: Int = 0
    var tabBeforeIndex: Int = 0
    var VCArr: [UIViewController] = []
    var authority: StudyDetailViewState = .member
    let state: [String] = ["공지사항", "스터디 정보", "채팅"]
    let childPageView = UIPageViewController(transitionStyle: .scroll,
                                             navigationOrientation: .horizontal,
                                             options: nil)
    lazy var tapSege = UISegmentedControl(items: state)
    lazy var selectedUnderLine = UIView()
    lazy var moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "more"),
                                          style: .done,
                                          target: self,
                                          action: #selector(moreButtonDidTap))
    let appearance = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        getPushEvent ? goDetailPage(): nil
        noticePushEvent ? goNoticePage(): nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyState ? presenter?.showApplyUserList(studyID: studyID!) : nil
        applyState = false
    }
    
    func attribute() {
        self.do {
            if let title = studyInfo?.title {
                $0.title = title
            } else {
                $0.title = studyTitle
            }
        }
        
        if let firstVC = VCArr.first {
            childPageView.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
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
            $0.centerXAnchor.constraint(equalTo: tapSege.centerXAnchor, constant: -view.frame.width / 3).isActive = true
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
    
    /// 푸쉬 이벤트가 스터디 관련일때 스터디 탭으로 초기 화면 구성
    func goDetailPage() {
        tapSege.selectedSegmentIndex = 1
        UIView.animate(withDuration: 0.2) {
            self.selectedUnderLine.transform
                = CGAffineTransform(translationX: self.view.frame.width / 3 * CGFloat(1), y: 0)
        }
        self.childPageView.setViewControllers([VCArr[1]],
                                              direction: .forward,
                                              animated: false,
                                              completion: nil)
        self.getPushEvent = false
    }
    
    /// 푸쉬 이벤트가 공지 관련일때 공지 탭으로 초기 화면 구성
    func goNoticePage() {
        tapSege.selectedSegmentIndex = 0
        self.childPageView.setViewControllers([VCArr[0]],
                                              direction: .forward,
                                              animated: false,
                                              completion: nil)
        self.noticePushEvent = false
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
        //스터디 삭제하기
        TerminalAlertMessage.show(controller: self, type: .DeleteStudyView)
        TerminalAlertMessage.getAlertCompleteButton().addTarget(self, action: #selector(deleteStudyCompleteButtonDidTap), for: .touchUpInside)
    }
    
    func leaveStudyButtonDidTap() {
        //스터디 나가기
        TerminalAlertMessage.show(controller: self, type: .LeaveStudyView)
        TerminalAlertMessage.getAlertCompleteButton().addTarget(self, action: #selector(leaveStudyCompleteButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - @objc
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
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
            LoadingRainbowCat.hide()
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
