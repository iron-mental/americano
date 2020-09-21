//
//  StudyCategoryLocalDataManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyCategoryLocalDataManager: StudyCategoryLocalDataManagerInputProtocol {
    func retrieveStudyCategory() -> [Category] {
        let arr = [
            Category(name: UIImage(named: "set")!), Category(name: UIImage(named: "set")!), Category(name: UIImage(named: "set")!), Category(name: UIImage(named: "set")!), Category(name: UIImage(named: "set")!), Category(name: UIImage(named: "set")!), Category(name: UIImage(named: "set")!), Category(name: UIImage(named: "set")!), Category(name: UIImage(named: "set")!), Category(name: UIImage(named: "set")!), Category(name: UIImage(named: "set")!), Category(name: UIImage(named: "set")!)
        ]
        return arr
    }
    
}
