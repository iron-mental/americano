//
//  LocalStudyList+CoreDataProperties.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//
//

import Foundation
import CoreData


extension LocalStudyList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalStudyList> {
        return NSFetchRequest<LocalStudyList>(entityName: "LocalStudyList")
    }

    @NSManaged public var studyList: [String]?
    @NSManaged public var testString: String?

}

extension LocalStudyList : Identifiable {

}
