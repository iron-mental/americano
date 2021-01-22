//
//  DelegateHostView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class DelegateHostView: UIViewController {
    var presenter: DelegateHostPresenterProtocol?
    var userList: [Participate]?
    var userTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DelegateHostView: DelegateHostViewProtocol {
    func showDelegateHostResult(message: String) {
//        <#code#>
    }
    
    func showError() {
//        <#code#>
    }
}

extension DelegateHostView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
