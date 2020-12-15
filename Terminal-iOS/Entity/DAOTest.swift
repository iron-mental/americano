//
//  DAOTest.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import CoreData

protocol DAO {
    var context: NSManagedObjectContext { get set }
//    func fetch() -> LocalUserInfo
}

class DAOTest: DAO {
    static let shared = CoreDataManager()
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    lazy var context = appDelegate.persistentContainer.viewContext
    
//    func fetch() -> LocalUserInfo {
////        let fetchRequest =
//    }
}
