//
//  LicensesView.swift
//  Terminal-iOS
//
//  Created by once on 2021/03/06.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class LicensesView: UIViewController {
    let libraryList: [String] = ["Alamofire",
                                 "Firebase/Analytics",
                                 "Firebase/Crashlytics",
                                 "Kingfisher",
                                 "lottie-ios",
                                 "NMapsMap",
                                 "SwiftyJSON",
                                 "SwiftLint",
                                 "SwiftKeychainWrapper",
                                 "Then"]
    let licenseList = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        self.do {
            $0.title = "오픈소스 라이센스"
            $0.view.backgroundColor = .appColor(.terminalBackground)
        }
        self.licenseList.do {
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.delegate = self
            $0.dataSource = self
            $0.register(LicenseCell.self, forCellReuseIdentifier: LicenseCell.cellID)
        }
    }
    
    private func layout() {
        self.view.addSubview(licenseList)
        
        self.licenseList.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        }
    }
}

extension LicensesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libraryList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = LicenseDetailView()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LicenseCell.cellID, for: indexPath) as! LicenseCell
        let libray = libraryList[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.setData(library: libray)
        return cell
    }
}
