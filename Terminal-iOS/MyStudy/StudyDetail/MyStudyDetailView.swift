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
    case StudyDetail
    case Chat
}

final class MyStudyDetailView: UIViewController {
    var presenter: MyStudyDetailPresenterProtocol?
    
    var viewState: MyStudyDetialInitView = .StudyDetail
    let appearance = UINavigationBarAppearance()
    var applyState: Bool?
    var alertID: Int?
    var studyID: Int? { didSet { setPageControllerChild() } }
    var studyTitle: String?
    var pageBeforeIndex: Int = 0
    var vcArr: [UIViewController] = []
    let state: [String] = ["공지사항", "스터디 정보", "채팅"]
    var studyInfo: StudyDetail?
    var userList: [Participate] = []
    var authority: StudyDetailViewState = .member
    lazy var tapSege = UISegmentedControl(items: state)
    lazy var selectedUnderLine = UIView()
    lazy var moreButton = UIBarButtonItem()
    let childPageView = UIPageViewController(transitionStyle: .scroll,
                                             navigationOrientation: .horizontal,
                                             options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            if let title = studyInfo?.title {
                $0.title = title
            } else if let title = studyTitle {
                $0.title = title
            }
        }
        
        self.navigationItem.do {
            $0.largeTitleDisplayMode = .always
        }
        
        self.appearance.do {
            $0.configureWithTransparentBackground()
        }
        
        self.do {
            $0.view.backgroundColor = .appColor(.terminalBackground)
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
            $0.tintColor = .appColor(.terminalBackground)
            $0.clearBG()
            $0.selectedSegmentTintColor = .clear
            $0.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        }
        
        self.moreButton.do {
            $0.image = UIImage(systemName: "ellipsis")?.withConfiguration(UIImage.SymbolConfiguration(weight: .regular))
            $0.target = self
            $0.action = #selector(moreButtonDidTap)
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
            self.childPageView.setViewControllers([self.vcArr[0]],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
            self.pageBeforeIndex = 0
            self.selectedUnderLine.transform
                = CGAffineTransform(translationX: CGFloat(pageBeforeIndex), y: 0)
        case .StudyDetail:
            self.tapSege.selectedSegmentIndex = 1
            self.childPageView.setViewControllers([self.vcArr[1]],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
            self.pageBeforeIndex = 1
            self.selectedUnderLine.transform
                = CGAffineTransform(translationX: self.view.frame.width / CGFloat(state.count) * CGFloat(pageBeforeIndex), y: 0)
        case .Chat:
            self.tapSege.selectedSegmentIndex = 2
            self.childPageView.setViewControllers([self.vcArr[2]],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
            self.pageBeforeIndex = 2
            self.selectedUnderLine.transform
                = CGAffineTransform(translationX: (self.view.frame.width / CGFloat(state.count)) * CGFloat(pageBeforeIndex), y: 0)
        }
    }
    
    func layout() {
        [tapSege, selectedUnderLine, childPageView.view].forEach { view.addSubview($0) }
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
            $0.widthAnchor.constraint(equalToConstant: view.frame.width / CGFloat(state.count)).isActive = true
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
        presenter?.addNoticeButtonDidTap(studyID: studyID!)
    }
    
    func editStudyButtonDidTap() {
        if let studyDetail = vcArr[1] as? StudyDetailView,
           let targetStudy = studyDetail.studyInfo {
            let location = targetStudy.location
            let mainImage = studyDetail.mainImageView.image ?? nil
            presenter?.editStudyButtonDidTap(study: targetStudy, location: location, mainImage: mainImage)
        }
    }
    
    func applyListButtonDidTap() {
        presenter?.showApplyUserList(studyID: studyID!)
    }
    
    func delegateHostButtonDidTap() {
        if let userList = studyInfo?.participate,
           let userID = KeychainWrapper.standard.string(forKey: "userID") {
            let filterUserList = userList.filter { $0.userID != Int(userID) }
            presenter?.delegateHostButtonDidTap(studyID: studyID!, userList: filterUserList)
        }
    }
    
    func deleteStudyButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .DeleteStudyView)
        TerminalAlertMessage.getRightButton().addTarget(self,
                                                        action: #selector(deleteStudyCompleteButtonDidTap),
                                                        for: .touchUpInside)
    }
    
    func leaveStudyButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .LeaveStudyView)
        TerminalAlertMessage.getRightButton().addTarget(self,
                                                        action: #selector(leaveStudyCompleteButtonDidTap),
                                                        for: .touchUpInside)
    }
    
    func reportButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .ReportContentView)
        TerminalAlertMessage.getRightButton().addTarget(self, action: #selector(reportButtonConfirmed), for: .touchUpInside)
    }
    
    func setPageControllerChild() {
        self.vcArr = [NoticeWireFrame.createNoticeModule(studyID: studyID!, parentView: self),
                      StudyDetailWireFrame.createStudyDetail(parent: self,
                                                             studyID: studyID!,
                                                             state: .member,
                                                             studyTitle: studyTitle ?? ""),
                      ChatWireFrame.createChatModule()]
        
        if let noticeView = vcArr[0] as? NoticeViewProtocol {
            noticeView.viewLoad()
        }
    }
    
    // MARK: - @objc
    
    @objc func indexChanged(_ sender: NSObject) {
        var selectedIndex = 0
        
        if let index = (sender as? UISegmentedControl)?.selectedSegmentIndex {
            selectedIndex = index
        } else if let pageViewController = sender as? UIPageViewController {
            if let viewControllers = pageViewController.viewControllers {
                if let index = vcArr.firstIndex(of: viewControllers[0]) {
                    selectedIndex = index
                }
            }
        }
        
        switch selectedIndex {
        case 0: viewState = .Notice
        case 1: viewState = .StudyDetail
        case 2: viewState = .Chat
        default: print("들어오지 않아요")
        }
        
        UIView.animate(withDuration: 0.2) { [self] in
            self.selectedUnderLine.transform = CGAffineTransform(translationX: self.view.frame.width / CGFloat(state.count) * CGFloat(selectedIndex), y: 0)
        }
        
        // PageView paging
        let currentView = self.vcArr
        let nextPage = selectedIndex
        
        // if 현재페이지 < 바뀔페이지
        // else if 현재페이지 > 바뀔페이지
        if self.pageBeforeIndex < nextPage {
            let nextVC = currentView[nextPage]
            self.childPageView.setViewControllers([nextVC], direction: .forward, animated: true)
        } else if self.pageBeforeIndex > nextPage {
            let prevVC = currentView[nextPage]
            self.childPageView.setViewControllers([prevVC], direction: .reverse, animated: true)
        }
        self.pageBeforeIndex = nextPage
    }
    
    @objc func moreButtonDidTap() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let noticeAdd = UIAlertAction(title: "공지사항 추가", style: .default) { _ in self.addNoticeButtonDidTap() }
        let studyEdit = UIAlertAction(title: "스터디 정보 수정", style: .default) { _ in self.editStudyButtonDidTap() }
        let applyList = UIAlertAction(title: "신청자 목록", style: .default) { _ in self.applyListButtonDidTap() }
        let delegateHost = UIAlertAction(title: "방장 위임하기", style: .default) { _ in self.delegateHostButtonDidTap() }
        let deleteStudy = UIAlertAction(title: "스터디 삭제하기", style: .destructive) { _ in self.deleteStudyButtonDidTap() }
        let reportStudy =  UIAlertAction(title: "신고하기", style: .default) {_ in self.reportButtonDidTap() }
        let leaveStudy = UIAlertAction(title: "스터디 나가기", style: .destructive) { _ in self.leaveStudyButtonDidTap() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        if authority == .host {
            [ noticeAdd, studyEdit, applyList, delegateHost, reportStudy, deleteStudy, leaveStudy, cancel ].forEach { alert.addAction($0) }
        } else if authority == .member {
            [ reportStudy, leaveStudy, cancel ].forEach { alert.addAction($0) }
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
                self.present(alert, animated: true, completion: nil)
                
            }
        } else {
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func leaveStudyCompleteButtonDidTap() {
        presenter?.leaveStudyButtonDidTap(studyID: studyID!)
        TerminalAlertMessage.dismiss()
    }
    
    @objc func deleteStudyCompleteButtonDidTap() {
        presenter?.deleteStudyButtonDidTap(studyID: studyID!)
        TerminalAlertMessage.dismiss()
    }
    
    @objc func reportButtonConfirmed() {
        TerminalAlertMessage.dismiss()
        if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController"),
           let castContentViewController = contentViewController as? UIViewController {
            if let alertView = castContentViewController.view {
                if let messageView = alertView as? AlertReportContentView {
                    guard let message =  messageView.editMessageTextView.text,
                          let id = studyID else { return }
                    if let studyDetailView = vcArr[1] as? StudyDetailViewProtocol {
                        studyDetailView.presenter?.reportConfirmButtonDidTap(studyID: id, reportMessage: message)
                    }
                }
            }
        }
    }
}

// MARK: UIPageViewController extension

extension MyStudyDetailView: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcArr.firstIndex(of: viewController), index > 0 else { return nil }
        let previousIndex = index - 1
        return vcArr[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = vcArr.firstIndex(of: viewController),
              index < (vcArr.count - 1) else { return nil }
        let nextIndex = index + 1
        return vcArr[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        indexChanged(pageViewController)
    }
}

extension MyStudyDetailView: MyStudyDetailViewProtocol {
    func setting(caller: UIViewController) {
        
        if let studyDetailView = vcArr[1] as? StudyDetailViewProtocol {
            if type(of: caller) == StudyDetailView.self {
                //스터디 디테일이 콜했을 경우 처리
                
                //공지에 state 심어주고
                if let noticeView = vcArr[0] as? NoticeView {
                    noticeView.state = studyDetailView.state
                }
                //메인스터디디테일에 정보 심어주고
                self.studyInfo = studyDetailView.studyInfo
                self.authority = studyDetailView.state
                
                // 탈퇴한 스터디 핸들링 해주고
                if authority != .host && authority != .member {
                    self.hideLoading()
                    showToast(controller: self, message: "속해있는 스터디가 아닙니다.", seconds: 1) {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    // 알림으로 진입한거 핸들링 해주고
                    if applyState == nil {
                        self.hideLoading()
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [self] in
                            applyState! ? presenter?.showApplyUserList(studyID: studyID!) : nil
                        }
                    }
                }
            }
            attribute()
            layout()
            view.layoutIfNeeded()
        }
    }
    
    func showLeaveStudyComplete(message: String) {
        hideLoading()
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.popViewController(animated: true)
            if let view = self.navigationController?.viewControllers[0] as? MyStudyMainViewProtocol {
                view.presenter?.viewDidLoad()
            }
        }
    }
    
    func showLeaveStudyFailed(message: String) {
        hideLoading()
        showToast(controller: self, message: message, seconds: 1, completion: nil)
    }
    
    func showDeleteStudyComplete(message: String) {
        hideLoading()
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.popViewController(animated: true)
            if let view = self.navigationController?.viewControllers[0] as? MyStudyMainViewProtocol {
                view.presenter?.viewDidLoad()
            }
        }
    }
    
    func showDeleteStudyFailed(message: String) {
        hideLoading()
        showToast(controller: self, message: message, seconds: 1)
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
