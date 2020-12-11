//
//  TestViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/03.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import SwiftyJSON

struct Apply {
    let title: String
    let content: String
}

class TestViewController: UIViewController {
    let testView = UITableView()
    let tempArr: [Apply] = [Apply(title: "안녕하세여", content: "후후후후후후ㅜ후후후후후후후후후ㅜ후후후ㅜ훟후후후후후후ㅜ후후후ㅜ훟후후후후후후ㅜ후후후ㅜ훟ㅜ훟"),
                            Apply(title: "안녕하세여", content: "후후후후후후ㅜ후후후ㅜ훟"),
                            Apply(title: "안녕하세여", content: "후후후후후후ㅜ후후후ㅜ훟"),
                            Apply(title: "안녕하세여", content: "후후후후후후ㅜ후후후ㅜ훟")]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testView)
        testView.do {
            $0.rowHeight = 80
            $0.register(ApplyListCell.self, forCellReuseIdentifier: ApplyListCell.cellID)
            $0.delegate = self
            $0.dataSource = self
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
    }
}

extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.testView.dequeueReusableCell(withIdentifier: ApplyListCell.cellID, for: indexPath) as! ApplyListCell
        cell.title.text = tempArr[indexPath.row].title
        cell.contents.text = tempArr[indexPath.row].content
        return cell
    }
    
    func handleNotifData() {
            let pref = UserDefaults.init(suiteName: "group.id.gits.notifserviceextension")
            let notifData = pref?.object(forKey: "NOTIF_DATA") as? NSDictionary
            let aps = notifData?["aps"] as? NSDictionary
            let alert = aps?["alert"] as? NSDictionary
            let body = alert?["body"] as? String
            
        }
}
