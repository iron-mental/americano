//
//  TestForCoreData+CoreDataProperties.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//
//

import Foundation
import CoreData


extension TestForCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestForCoreData> {
        return NSFetchRequest<TestForCoreData>(entityName: "TestForCoreData")
    }

    @NSManaged public var stringTest: String?

}

extension TestForCoreData : Identifiable {

}
