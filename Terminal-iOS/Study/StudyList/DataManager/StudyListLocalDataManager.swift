//
//  StudyListLocalDataManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import CoreData

class StudyListLocalDataManager: StudyListLocalDataManagerInputProtocol {
//    static let shared: CoreDataManager = CoreDataManager()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    
    func retrieveStudyList() throws -> [Study] {
        return [Study(id: 0, title: "", introduce: "", image: "", sigungu: "", leaderImage: "", createdAt: "", members: 0, isMember: true)]
    }
    func saveStudylist(studyList: [Study]) {
        let test = LocalStudyList(context: context!)
        test.studyList = ["이것도 되냐?"]
        test.testString = "리얼테스트"
        print(test)
        print("첫",test)
//        let test = TestForCoreData
        do {
            try self.context?.save()
            print("위",test)
        }
        catch {
            print("아래",test)
        }
        
    }
}
