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
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    
    func retrieveStudyList() throws -> [Study] {
        return [Study(id: 0, title: "", introduce: "", image: "", sigungu: "", leaderImage: "", createdAt: "", members: 0, isMember: true)]
    }
    func saveStudylist(studyList: [Study]) {
        print(CoreDataManager.shared.context)
//        CoreDataManager.shared.context
//        let test = LocalStudyList(context: context!)
//        var result: [Any]?
//        test.list = [TestStudy(id: 93333999), TestStudy(id: 333333)]
//
//        do {
//            try self.context?.save()
//        }
//        catch {
//        }
//
//        do {
//            result = try self.context?.fetch(LocalStudyList.fetchRequest())
//            print("여기서 1,3 나오면 찐", result)
//            print(type(of: result))
//        }
//        catch {
//
//        }
        
    }
}
