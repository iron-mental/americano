//
//  StudyDetailView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyDetailView: UIViewController {
    let state: [String] = ["공지사항", "스터디 정보", "채팅"]
    let childPageView = PageViewController()
    
    lazy var tabSege = UISegmentedControl(items: state)
    lazy var selectedUnderLine = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.navigationController?.navigationBar.standardAppearance = appearance
        }
        tabSege.do {
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14),
                                       .foregroundColor: UIColor.gray], for: .normal)
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16),
                                       .foregroundColor: UIColor.white], for: .selected)
            $0.selectedSegmentIndex = 0
            $0.layer.cornerRadius = 0
            $0.backgroundColor = .clear
            $0.tintColor = UIColor.appColor(.terminalBackground)
            $0.clearBG()
            $0.selectedSegmentTintColor = .clear
            $0.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        }
        selectedUnderLine.do {
            $0.backgroundColor = .white
        }
//        scrollView.do {
//            $0.delegate = self
//            $0.isPagingEnabled = true
//            $0.showsHorizontalScrollIndicator = false
//            $0.backgroundColor = .red
//            $0.bounces = false
//        }
//        notice.do {
//            $0.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.cellID)
////            $0.delegate = self
////            $0.dataSource = self
//            $0.isScrollEnabled = false
//            $0.bounces = false
//            $0.rowHeight = Terminal.convertHeigt(value: 123)
//        }
        childPageView.view.backgroundColor = .red
    }
    
    func layout() {
        view.addSubview(tabSege)
        view.addSubview(selectedUnderLine)
        addChild(childPageView)
        view.addSubview(childPageView.view)
        childPageView.didMove(toParent: self)
        
        tabSege.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 38)).isActive = true
        }
        selectedUnderLine.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: tabSege.bottomAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: tabSege.centerXAnchor, constant: -view.frame.width / 3).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        childPageView.view.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: tabSege.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        let selectedIndex = CGFloat(sender.selectedSegmentIndex)
        
        // 탭바 애니메이션
        UIView.animate(withDuration: 0.5) {
            self.selectedUnderLine.center.x = self.view.frame.width / 6 * ((selectedIndex * 2) + 1)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.selectedUnderLine.transform = CGAffineTransform(scaleX: 1.6, y: 1)
        } completion: { (finish) in
            UIView.animate(withDuration: 0.4, animations: {
                self.selectedUnderLine.transform = CGAffineTransform.identity
            })
        }
        
        // ScrollView ContentOffset 설정
//        let xPosition = selectedIndex * view.frame.width
//        let newOffset = CGPoint(x: xPosition, y: 0)
//        scrollView.contentOffset = newOffset
    }
}

// 스크롤뷰 애니메이션 delegate
extension StudyDetailView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width

        tabSege.selectedSegmentIndex = Int(index)
        
        // UnderLine animate
        UIView.animate(withDuration: 0.5) {
            self.selectedUnderLine.center.x = self.view.frame.width / 6 * ((index * 2) + 1)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.selectedUnderLine.transform = CGAffineTransform(scaleX: 1.6, y: 1)
        } completion: { (finish) in
            UIView.animate(withDuration: 0.4, animations: {
                self.selectedUnderLine.transform = CGAffineTransform.identity
            })
        }
    }
}


//extension StudyDetailView: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return noticeTitleText.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = notice.dequeueReusableCell(withIdentifier: NoticeCell.cellID, for: indexPath) as! NoticeCell
//        cell.noticeTitle.text = noticeTitleText[indexPath.row]
//        return cell
//    }
//}
